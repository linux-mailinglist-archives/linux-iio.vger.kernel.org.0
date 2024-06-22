Return-Path: <linux-iio+bounces-6729-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BDD913700
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 01:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62222819E9
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 23:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6334E12C819;
	Sat, 22 Jun 2024 23:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b="rrA+FhgU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JXvFdB/E"
X-Original-To: linux-iio@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BFA12C476;
	Sat, 22 Jun 2024 23:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719100313; cv=none; b=VS9L0gUlrpSvrTsBEua+TqCuBiUgIhDtp+fT8iyXj8+MogzwHjo54SVJPdhZyJaZ5DCkD654Bo4AnD9XOkbLWbkglcZpTUvZalCB5NK81t7m6Td/z8+KPrDEBWwgkz5o+OAHCKYjjGxdy9u6ogBoUPiv9AaJVO6zxeCw1SCZUFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719100313; c=relaxed/simple;
	bh=N985mFDxg05B2ZgOhn/VCO+t3AAKydd5JE/vjygQENk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=bpLYu/DX6HFI0b+T3rPUGybofahz9FYlTVYVDlcvpOz4keUgeu1Qd+WcFhH/b2vry2V10+gW6s2LeJEc4byAKWPfAMmgodbxFNd/wIPdQ2Vq3mQdFuiwM2lEJm6fvJmyFYOkoOutVzRdZYzyBxNo+ur1ZQCWPQgMSelEfO8fuuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=testtoast.com; spf=pass smtp.mailfrom=testtoast.com; dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b=rrA+FhgU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JXvFdB/E; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=testtoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=testtoast.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B74A3114011F;
	Sat, 22 Jun 2024 19:51:50 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Sat, 22 Jun 2024 19:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=testtoast.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1719100310; x=
	1719186710; bh=0jhV1T7izwhyf4o2GERofzjnCVqRgYwJja6ZJ4p46AA=; b=r
	rA+FhgUr30STWZnynrTFWfHH/mp1lpZ5sC23m4hyGHJgdm8Eks0glpL4iygMiDHN
	39e5CuUa7F6/eVDvU6b3KCJAA6WBBHUM0wa39XksDXmtKFaiuwdIARWVdjG4H4lS
	JRceE7987fKvSWiqPeAMcbTq6Qvq9F3Tydi7IBNAuHVHkeTcFq4MOMwT15QvVEsQ
	5ohAkVsgInPqJEmH9g+1SuQUbmCdojQNxyRHRBdLsQNqt2zc5a+ihRVitvMJ7/dl
	NzBOLYVeIgiJtj1xttyf+zSIeXsH0FrlceYlm6gG05NJ1q9qNj8c/MtUjK2EouL8
	os+4vrVNdrLOuJEyMxl1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719100310; x=1719186710; bh=0jhV1T7izwhyf4o2GERofzjnCVqR
	gYwJja6ZJ4p46AA=; b=JXvFdB/EcClqQMNo+lmxZf7aZeEiWdvDh0vbshoYjYu5
	iywnQCns3FaHNFGVVDmeuvDrqp/LlXQS0rhEVEswKtJLGDLV8Ma+6c7ctlIX4tqS
	qc2qvdIUts1q9XUpTUOyX+/cDb8+tZn8P7FUl5wHxFvXdGC8nmC2P0hn/JIzXCw6
	8wTkHNWTS+X7cJFZ2kymM7y969iDz+3vZh8/9Lz9+hdDCXvrVrC0tlOqG0WsnWSs
	NVinhlP8vP81V4Axv/u6/Ll2F/bNH6HsQQHe4y1QYPurBPSXXrdE/5I8ibTuPp+A
	pk99Ad+us90qKsnYWt4QPsWxB324F3ttRT0jj7HD1Q==
X-ME-Sender: <xms:lmN3ZhtK8pJbGZm8xlM6YgW2XJ4vdeLL7lj5YLPAQsDnk3E4RJ2muw>
    <xme:lmN3Zqfrl0JxmhVfuHMV8sf30OdVXgMrg__CkXaJXXEieCMIadWlULWWt6-joT1Uq
    JTPWzcXU5nmT_lNOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefjedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftfih
    rghnucghrghlkhhlihhnfdcuoehrhigrnhesthgvshhtthhorghsthdrtghomheqnecugg
    ftrfgrthhtvghrnhephedvveeigedujeeufeegffehhfffveduhfeijefgtdffteelgfet
    ueevieduieejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrh
    homheprhihrghnsehtvghsthhtohgrshhtrdgtohhm
X-ME-Proxy: <xmx:lmN3Zky4u98OJdRBglloXb_c6fKBE1R9Nc5_yFJVBtOknnbrdTP08Q>
    <xmx:lmN3ZoMsdf3DjEFjbNTrvxCa5ejeU0_YhyIALYtyr0Ec2K-gseUq0Q>
    <xmx:lmN3Zh9q6Q-Qdcl6dDAtsAVwDpBRhvAYttKVbAJctkYNMNhkl940Kw>
    <xmx:lmN3ZoWlNLOpDQjztOYcE3BjLZzQB0vX-PLmf8pvIRBWRcxLUYnJCg>
    <xmx:lmN3ZgerumyZrPtZk68plpDtRn1Df_9yHP2_OBTWr8iRR0YAu8jgMOk8>
Feedback-ID: idc0145fc:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 75C7CA60078; Sat, 22 Jun 2024 19:51:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0b0f5909-343d-4a79-bcc8-21bcd6a290a4@app.fastmail.com>
In-Reply-To: <20240617220535.359021-8-macroalpha82@gmail.com>
References: <20240617220535.359021-1-macroalpha82@gmail.com>
 <20240617220535.359021-8-macroalpha82@gmail.com>
Date: Sun, 23 Jun 2024 11:51:30 +1200
From: "Ryan Walklin" <ryan@testtoast.com>
To: "Chris Morgan" <macroalpha82@gmail.com>, linux-sunxi@lists.linux.dev
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, "Mark Brown" <broonie@kernel.org>,
 "Lee Jones" <lee@kernel.org>, "Samuel Holland" <samuel@sholland.org>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, sre@kernel.org,
 "Chen-Yu Tsai" <wens@csie.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Rob Herring" <robh@kernel.org>,
 lars@metafoo.de, "Chris Morgan" <macromorgan@hotmail.com>
Subject: Re: [PATCH 7/8] power: supply: axp20x_battery: add support for AXP717
Content-Type: text/plain

On Tue, 18 Jun 2024, at 10:05 AM, Chris Morgan wrote:

> From: Chris Morgan <macromorgan@hotmail.com>

Thanks Chris!

> Add support for the AXP717 PMIC battery charger. The AXP717 differs
> greatly from existing AXP battery chargers in that it cannot measure
> the discharge current. 

The battery does seem to report a discharge current with no USB power connected, do you think this is not accurate?

localhost:/sys/class/power_supply/axp20x-battery# cat current_now
433000

Otherwise Working charge state, percentage and current/voltage. Thanks!

Tested-by: Ryan Walklin <ryan@testtoast.com>

Regards,

Ryan

