Return-Path: <linux-iio+bounces-27281-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2966CCD43AC
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 19:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB60330076AD
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 18:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C765A303A35;
	Sun, 21 Dec 2025 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ed9nR4Hq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F16C2FF140;
	Sun, 21 Dec 2025 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766340422; cv=none; b=G03yH5kxLVG9J7VOHc4NljeMXuUseXaZtEmXk5HCZmuFzwonUIEgiamJ3DZ3kXL1OC4HKKDO6whqIHbsdI/mpiftkg9imCBTOtfm9cc6ZzXRwdUMXassuWwRZrzAE+1/5cMSbvzPccG9D2z74iKjCE7dZLiCD+UMLKoho2rig9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766340422; c=relaxed/simple;
	bh=JFSGY99IUhQdmBgMFlXaqBYLsamJYbE1yy5TUvnBoY0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LNnPtALNIanBsyErq0j2XurpSl3cHafASeHL7s+p7oYp1H+AUgVAW1wTZEBYJ9MgvJ7ky72O8L2ArhG+JokpctcEzzbqJnXfLPqD6QEV4LESnUDbVXIkkGF7m8TsbhI20NF5CKjmxd6XaATzXmM0baukhWOQkiBFdtP8+R8/FdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ed9nR4Hq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28853C4CEFB;
	Sun, 21 Dec 2025 18:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766340422;
	bh=JFSGY99IUhQdmBgMFlXaqBYLsamJYbE1yy5TUvnBoY0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ed9nR4Hq+rsNSnrTHCf8+tXRwqQw0VJZpoholyXG7GllYIWRWiPryyauq3oCDDDZY
	 /RN24CgCp+Y5y7/dWyTIQ9NMHquDOnOCup1ziEbbmaDoJkkOrfG05VNaet8a+0sJiP
	 pIeoWm+o+Y4Q9yansPDLiuMdbMFA81X9DiFC8LGY/VDLNbHbB7ySCV6fDFZ2rUt1Fc
	 UWC4eBQA6LkyLBPZEQo4TUnNA5IsmSe4beTtZ3jUeM5cPhJQsED5OfncLeQ0OpVSGc
	 kK4kEG+wfjtG+1FXFgVWroo62V3E6sylwVRdmgKs+NTDS4vGLbi89P46Ay4Z2z9FZV
	 N+v3xrQHGZ+/g==
Date: Sun, 21 Dec 2025 18:06:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Petre Rodan <petre.rodan@subdimension.ro>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 01/14] iio: pressure: mprls0025pa: Kconfig allow bus
 selection
Message-ID: <20251221180652.779d4250@jic23-huawei>
In-Reply-To: <aUYoZa90Sboso6eP@debian-BULLSEYE-live-builder-AMD64>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
	<20251218-mprls_cleanup-v1-1-b36a170f1a5c@subdimension.ro>
	<aUYoZa90Sboso6eP@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Dec 2025 01:39:01 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 12/18, Petre Rodan wrote:
> > Allow the user to select either the SPI or the i2c bus specific
> > module and autoselect core if needed.
> > 
> > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> > ---  
> LGTM
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Applied this patch to the togreg branch of iio.git.
Initially pushed out as testing for 0-day to take a look.

Thanks,

Jonathan

