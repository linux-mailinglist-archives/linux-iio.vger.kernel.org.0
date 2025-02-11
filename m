Return-Path: <linux-iio+bounces-15338-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08923A30ADC
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 12:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E0477A1A35
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 11:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8521FA854;
	Tue, 11 Feb 2025 11:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="BOdRE3La";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dj0NE2f9"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E821F8AF8;
	Tue, 11 Feb 2025 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739274995; cv=none; b=CzT0s0xNSM6o5XqbidNkIoYvhFgZJ58Ruv9itg/uLTeXFaDLTsAJVYyk1Nv27e4m7B2pvcqEX98y3drb9zVCCM9v6gXcppvmdTZZyAhMpD4I2x6vKfY1QPKvlzcZyrFU+bY8e6DNAVtHEnqI0gZki6rOmQA8ZaKSRzSbD6E7zuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739274995; c=relaxed/simple;
	bh=rd29cpkgIwrU7/mh++kq6VmSBZdKxSQR4Rl/ZCGILEM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Iuym5OYRipWyXXmSgGCHinWia+9CZGpdt3vEx3wEZ6f4/9Btssv4rrAgyNtaUHuvjQpgrio2c9tucVWUegfRgs4tgIjjnkPuc1FK6Yc23+ff8fn/KGaIlT2XyINxbC6piHbTRGwSh4lqmKIsV6KQCOrd1srHDLa4TYLA7fcfMiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=BOdRE3La; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dj0NE2f9; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id ABA8413808C3;
	Tue, 11 Feb 2025 06:56:32 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 11 Feb 2025 06:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1739274992;
	 x=1739361392; bh=SCgFKCz0WVFlk+/nGWCfvkfQS3PqNaxn3RNPH9+mh7c=; b=
	BOdRE3LaNTDlQADqs5Hkyc0y7uE6jlOpYdk72QHjqA3KEpUXPc2790a5yTzTGEc6
	Zr/+8Xe0dhc/Tz9MgNlp5wbRMfY0BoAmdOZfzxg0X28OgC2tEKax9a4DT7SYy8mO
	EoIy5GrlU4/8xaKMG6eqEAICm7+QGvHvY8Z8ex8czbEA0yn+/Rv4eQ6Y9xojZlyO
	YXP5i0OdOHdsehprYT2+ksC4ICkW6eXshnB8Qur2hNp5uj54i6m8u5t9+01Yzhbv
	CKAjOOJOqjy37PZNTUBXoFaPEtwlcvrjY/KQj9m4I/q9nl9+YtKAXr1rqynz4GhG
	IkHIl/nUcchALoUnvdMoOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739274992; x=
	1739361392; bh=SCgFKCz0WVFlk+/nGWCfvkfQS3PqNaxn3RNPH9+mh7c=; b=D
	j0NE2f9eUybBDBypcXB0Gfr24ZHt7WcVOxeVohAZmLBADkM5pDpBpntNC5/NeGrM
	TZn1DQNz83Gjw1Dcc1YKO9CmBigcqKE1JGyC3a3iH/OtRjbVqpLhtDLvUsJEvJky
	td6QB3+QvNo4KYCFsHA3+OJdrk6dXm1mJx/YYLd1orbS3aCszO6URTp6dWSx+rVa
	CXReLM09E+r4bbyvkEtfdv/dVAr70XnVU9BlMV+BKDQCMHc08CJOl4r3mb2fMLUm
	u2zObocPX+AwbuoxCRk9SmAzm1TYr9u5TtxYXSyt1Uo7d98bD45Yv9Lbpmd2VrpY
	BVTGugO0qHLamCmIB5A3A==
X-ME-Sender: <xms:8DqrZyI6N5j27bQ0fsKkQT0JRPOSxt0UVyH-NRT8Eo80-VEvcrxX7g>
    <xme:8DqrZ6JoDMm2ZDrHAl7RRE8bOM1rKWHM08TNqLleu3CQS8jBhEP8BSxTdbiUJq071
    FFGa5Xh84tsIYVzCDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegtdelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedv
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughmihhtrhihrdhtohhrohhkhh
    hovhesghhmrghilhdrtghomhdprhgtphhtthhopehlghhirhgufihoohgusehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheplhhkphesihhnthgvlhdrtghomhdprhgtphhtthhopehprh
    iivghmhihslhgrfidrkhhithhsiigvlhesihhnthgvlhdrtghomhdprhgtphhtthhopehr
    rggrghdrjhgruggrvhesihhnthgvlhdrtghomhdprhgtphhtthhopegsrhhoohhnihgvse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihgtvdefsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrvg
    eskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:8DqrZytxAqlN6V9ootafxgtKy8n_5mIlmoC3PP1rtvg5YyxKtr832A>
    <xmx:8DqrZ3Y9Pgo2Ue7-eGtuG9QM9Mxj_xw2jfwWHmRP4Uv-rHAGtD47HQ>
    <xmx:8DqrZ5bzw4AXGhO8JrtwHxoRRRT4nJi83FYFnP31nMsJps87YOgfcg>
    <xmx:8DqrZzAXdgPM9jr1Ft_sAe1Mn_YlatD3ZiSQMCFfUd0Zh3D98dvROA>
    <xmx:8DqrZ1P1831GY0oWJVBAkqiyOEjQYHiHgePr2JAYS3uj3q6SN0AL5Irz>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4443E2220072; Tue, 11 Feb 2025 06:56:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 11 Feb 2025 12:56:11 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: "kernel test robot" <lkp@intel.com>, "Raag Jadav" <raag.jadav@intel.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Mika Westerberg" <mika.westerberg@linux.intel.com>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, lgirdwood@gmail.com,
 "Mark Brown" <broonie@kernel.org>, "Sebastian Reichel" <sre@kernel.org>,
 "Jonathan Cameron" <jic23@kernel.org>,
 "Przemek Kitszel" <przemyslaw.kitszel@intel.com>,
 oe-kbuild-all@lists.linux.dev,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-iio@vger.kernel.org
Message-Id: <49396042-31f0-4d8e-aa54-d89093ab5709@app.fastmail.com>
In-Reply-To: <Z6s2cGMM9R6SZ9Le@smile.fi.intel.com>
References: <20250210064906.2181867-2-raag.jadav@intel.com>
 <202502102201.zLWaJC6V-lkp@intel.com> <Z6oZ9dnYrlp5djiQ@smile.fi.intel.com>
 <7c42e438-22f9-40d9-bb8e-24feb7d58e64@app.fastmail.com>
 <Z6sYAxRIeCzw12nY@smile.fi.intel.com>
 <c1184a91-e216-423d-b956-d4b22116a171@app.fastmail.com>
 <Z6siYlWfvfUvNLpX@smile.fi.intel.com>
 <279d9f32-a1c9-41aa-b15a-e1485877b2d5@app.fastmail.com>
 <Z6s2cGMM9R6SZ9Le@smile.fi.intel.com>
Subject: Re: [PATCH v4 01/20] driver core: Split devres APIs to device/devres.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Feb 11, 2025, at 12:37, Andy Shevchenko wrote:
>
> The problem this series solves at the beginning is that not all the consumers
> of device.h needs it, in many cases the device/devres.h (or subset of
> device/*.h) is enough to include. While solving this, it appears that
> the current code uses ERR_PTR() instead of IOMEM_ERR_PTR() in devm_*io*() APIs
> and kernel test robot found this and complained about. While solving
> this new issue, LKP found another issue that is circular dependency.
> But the original code only wants to have an access to IOMEM_ERR_PTR() which
> is in io.h and can be moved to err.h AFAICS. Does this sound reasonable?

Yes, that sounds fine to me. I agree that not including linux/io.h
from device/devres.h is a good idea, same as no longer including
linux/device.h from asm/io.h. Moving IOMEM_ERR_PTR() as you
describe is the right idea.

Side note: I looked at large-scale header file cleanups in the past,
and in general the result of that was that the best way to reduce the
indirect inclusions is by splitting data structure definitions from
inline functions that use those data structures. The definition of
"struct device" clearly has too many dependencies, and to make
this one better. There has actually been some good preparatory work
done by Kent Overstreet a while ago that moves structures out
(e.g. work_struct and mutex), but not yet struct device and
struct kobject, which are needed in many other headers. The tricky
part that needs to happen to actually make it useful later on is
to replace all the unnecessary indirect includes with the minimal
ones, and that is a huge amount of work.

     Arnd

