Return-Path: <linux-iio+bounces-10941-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D3D9AB2C1
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 17:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E40EAB24CDD
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 15:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683201BBBF1;
	Tue, 22 Oct 2024 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="oKd6iqyE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SgzCi/kL"
X-Original-To: linux-iio@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FED1BBBD4;
	Tue, 22 Oct 2024 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612309; cv=none; b=ZN4qqz6C6dZDecVvIBh2Wm+m0MZTFHfT5dCrYfc0DLl1j4CcymN9KdAZRrhhDlk0tkLp7PwMOXpt9WaCn1cP2b4WHLHmqDQFtJ3/7cjfQRivShiChhMYrxl5Uenvu8n9h1Iu9OERK4eEhmzsYolr/Z981o6briRYqIVo/Hs+hxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612309; c=relaxed/simple;
	bh=bMv2RfvG9XOlaqwsh9pWcR+b/BxW9RG7eKVnppfP8I4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rxVrhF1ht3+YI+YHqlryioADTyeop3XQ0UMC7e8dAQ1SwncO9egR/9acvD0Eupu/VIw1tx44ldoDgDL59mM2J3jjn64IHEvKkDUqVLFojvvLfqfxFi1pQ1iSKXW7OditiP1DXhwRee1ELIOInFTJa1AACVSoYsuU0STmqSqu5QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=oKd6iqyE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SgzCi/kL; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 988FB114006D;
	Tue, 22 Oct 2024 11:51:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 22 Oct 2024 11:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1729612305; x=
	1729698705; bh=bMv2RfvG9XOlaqwsh9pWcR+b/BxW9RG7eKVnppfP8I4=; b=o
	Kd6iqyEiDpRtN35gRiJ92Kkz+F69tppDxnQbeZnrTrqx1YTN+gceD2ccts9FBWe2
	iuAGu6sPHeRDziXeQC5szmiY+QzdU2rUYtTK+WknWSC/0+Ni03/r9UUq50hVnyTw
	GBbb6TS9VIXUdkU2gWMvSpjrc9xBDX6ACrelIQmFlSdo+LmLxiDjIz22xZpmCYoS
	SQeFVCLN2jRFqEKFXFpefDiRB5d/K9T/24CBvDoY3Hkzi5ES59VIVCCmm/PgtZhJ
	8WFaB6jZBmVx0H8CX12dgMDpiYg8oVCOToJc4ZzoPde9Pf0aG+j2Ylau8s7VXuGY
	ubb9p3AEXrGGNwEcMafAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729612305; x=1729698705; bh=bMv2RfvG9XOlaqwsh9pWcR+b/BxW
	9RG7eKVnppfP8I4=; b=SgzCi/kLKNULWEkNLsNuO7VpO9/McUFBf5Ssw8MyxtmN
	EQiOYzxIenk4T182Rdf4GrHS0p9nxIPqfhIhD2HjIiGK9VMkJx/RBUE7xLCu9mJE
	cT+ofCwsx7TPV1XNJAjQCZBwkKj5x46ZdhwsCEYSx169SCIaKi3peeIpbt+mE9yx
	XHCZXFKQyJI3gpWIbdZDnpYSLPPgrKFt03Clqjwve7WUMpZgLcLPxkjcKb7Tbr94
	zsCGRXFiOR8YMZ3JK3tqGR/mTuVZ56ey9NNXO8OrjJVRiK/Vi87KFppHqRVsxa2W
	ap7vHLVlR0+nIf2vJ+9+3wNzD+cVJvmNPOCZEqf3EA==
X-ME-Sender: <xms:EcoXZ062gl3ep7O_H8vnsxl3zLr56WY_xXyd0JtPYNkSiq7Wr8O0wA>
    <xme:EcoXZ17PTzzCZX2JwqQTHr5t8NW_4UzlXaedr0C3WGT0GIBCYPG3acBM8btYERDAj
    EIpE5OFiEEqdevGOg>
X-ME-Received: <xmr:EcoXZzcXUgiKHj788_KSM3BnNrRmqsjC7mlvQwTMz2LcVBlou-jV_02Rfj0sHE_ECvvMMBz7EqxsBNsNx8GC4pPsLzUHWrVvzpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeihedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhushhtihhnucghvghishhsuceojhhushhtihhnsehjuhhsthhinhifvg
    hishhsrdgtohhmqeenucggtffrrghtthgvrhhnpefgueegueeiheffkeektdetfffgffeu
    ieekvdefieejvdefiefgvefhiefhfefgveenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehjuhhsthhinhesjhhushhtihhnfigvihhsshdrtgho
    mhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hphhhilhhmsehmrghnjhgrrhhordhorhhgpdhrtghpthhtohepuggvrhgvkhhjohhhnhdr
    tghlrghrkhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghvihgtvghtrhgvvges
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhiihhosehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgrrhhssehmvght
    rghfohhordguvg
X-ME-Proxy: <xmx:EcoXZ5K4Zqm1mu1hSR8xDO3MLAiTxQZnHlAQIggxo4mbApUn5_psdw>
    <xmx:EcoXZ4KGa2mYDjD4eV0OJxvXvF8p67lh2oLBMccaRFoobuoXCGkeog>
    <xmx:EcoXZ6ytX7qhhGEj3nH1-YQQY2RJOdJ8f2fsI2Z6Qsln6OC79xZ_AA>
    <xmx:EcoXZ8IL8wWk_EdoLFMptBmd8rns3VouqBqu4uzAmiF9PIOlU4RuUQ>
    <xmx:EcoXZ6CAYSMmhUXxqwBiYSLLq8JAz3DDV53GQcOUqlSA3m5B15qymTj8>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Oct 2024 11:51:43 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,  Jonathan Cameron
 <jic23@kernel.org>,  Lars-Peter Clausen <lars@metafoo.de>,  Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>,  linux-iio@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,  "Derek J .
 Clark" <derekjohn.clark@gmail.com>,  Philip =?utf-8?Q?M=C3=BCller?=
 <philm@manjaro.org>
Subject: Re: [PATCH v3 3/6] dt-bindings: iio: imu: bmi270: Add Bosch BMI260
In-Reply-To: <ynhv4c4pyj72nsof6wwkaon22i6chd4ux5cb7hv4tmblwhv3aq@564biida44ii>
	(Krzysztof Kozlowski's message of "Mon, 21 Oct 2024 09:38:55 +0200")
References: <20241020220011.212395-1-justin@justinweiss.com>
	<20241020220011.212395-4-justin@justinweiss.com>
	<ynhv4c4pyj72nsof6wwkaon22i6chd4ux5cb7hv4tmblwhv3aq@564biida44ii>
Date: Tue, 22 Oct 2024 08:51:43 -0700
Message-ID: <87froom8z4.fsf@justinweiss.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krzysztof Kozlowski <krzk@kernel.org> writes:

> On Sun, Oct 20, 2024 at 03:00:07PM -0700, Justin Weiss wrote:
>> Add compatible ID for Bosch BMI260 to BMI270 documentation.
>
> This we see from the diff. Say something about the hardware, are they
> compatible? No? What are the differences?

Got it, I'll update the commit message.

The bmi260 has nearly identical register maps and capabilities as the
bmi270, but the devices have different chip IDs and require different
initialization firmware.

Thanks,
Justin

> Best regards,
> Krzysztof

