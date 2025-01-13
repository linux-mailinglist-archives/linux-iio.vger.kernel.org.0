Return-Path: <linux-iio+bounces-14304-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E02DA0C21B
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 20:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA7E7167469
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 19:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8161F8932;
	Mon, 13 Jan 2025 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="wxc2slGF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c0sbNU2t"
X-Original-To: linux-iio@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C1C1C760A;
	Mon, 13 Jan 2025 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736797897; cv=none; b=GhYbLTxEifyKpyDFcXuk004yOBR5FHPSQzZ9V6MXjZqhSVZ9uzlv2iOKmvU7q3VQUW+8hwLTg7borOfNTqnDN+nN2YOZ3F00z2A7ToF9n5HCngOKkRUoKQFrrqzVPMriaDWp/jmv4MwuuhoFHO/4DZCr7SAtZypllIrCEYeGMyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736797897; c=relaxed/simple;
	bh=0bHHgzrNqa3fYPBLBtN/WSM3ej4oelh0tp8dbE0JfhI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rwz8zuLCqL3NYSaaUqvQn5Cy4+O2uFVnngALZh4JHQSJZgIlfBw+e3mvlKku5lsaGT4la+YaVA1cUKuv5acXVNfdxO+crhlchGd/VNJe6KJmU8brDS3qlBArwZ76CmPAxJK5DR2nI4FViHr8XHuwwaHUD8NsN5OPAMRX5bDgXE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=wxc2slGF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c0sbNU2t; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DFF511140094;
	Mon, 13 Jan 2025 14:51:33 -0500 (EST)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Mon, 13 Jan 2025 14:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1736797893;
	 x=1736884293; bh=crQtvXcB4CVDtZoxgjvLjzhcmtpkH5xTXvUFColn2Kw=; b=
	wxc2slGFjmSg1ZPpG9iTjuTge+e8IcHRQFforpS8AlTUdQWEoqNAJ61qGXLxSF+8
	O/YxMJ/KDkuitUJd0+/u8wlhxCcz4OuocjM84bUyVOR4Nx1w4H9znvCdkT1qwvtp
	RXk+MWvrlkeP3JUB3OS3oSfdNUplnoBnQa4WjN7Ex4hbWnO8ubX6x1zqUCySfR6+
	zmUAr0CCBPMoJxRKQEBLZJ79fU79ESgzqmHf/yPCQjPaYCmGcfgXe9eUhi8TPonc
	3ijN5ApT+xTUD7/LqC9oNPRszHN4yeLI5LgldVBXFPNr4iTkqam8HuMQqhjER7Gf
	uQeiQg7GX8infZEIrgsn1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736797893; x=
	1736884293; bh=crQtvXcB4CVDtZoxgjvLjzhcmtpkH5xTXvUFColn2Kw=; b=c
	0sbNU2tODPGJt+hBXjOE6DH4DpovfgwL7PzDfRYZWB5iElWCXR1RWw2+TdF1nI3c
	Jm6csoAEefYOYMYTbXFVN7p+IO2Brfs0vJOonsMjYfgFhoAWFEIi/5C+TH10P/VC
	batAECJpZpnehwV8u8PIFvUI2Zytvkt+45cCKgO5j0ZjMzVTvTVM/6nsOyj+UIqK
	Bc/+GOqQpt5ymDTq8LNknH7rWGbxYpTuF9f/+RiQ/x4WGIm9dFIsbfUaqizxYVJh
	l8ia/ErXnM5G6e99QUPpmwSXN+fnLc/JjHSLcwiJ2hxTOdFd85knSOpGmrgtdlNU
	OQlf1KbhC5msq2bNdnD4g==
X-ME-Sender: <xms:xW6FZ_2OhmuguUoqXtmsNujknW_hmaIQ1KF3Ob6OPyyb4W7nsfDN9Q>
    <xme:xW6FZ-FL9CvROQN1lKHI9BKaksPmDh22R7jqE5KBVLYRJpZxNWz4sNdWbWaxjWxcV
    NjEIssVMLP1AI_ZrcU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfofgrrhhkucfrvggrrhhs
    ohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpefhuedvheetgeehtdehtdevheduvdejjefggfeijedvgeekhfefleeh
    keehvdffheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhnsggprhgtphht
    thhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrihgsrghluggrsegthh
    hrohhmihhumhdrohhrghdprhgtphhtthhopehjohhnrghthhgrnhdrtggrmhgvrhhonhes
    hhhurgifvghirdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrg
    gurgesihhnthgvlhdrtghomhdprhgtphhtthhopehjihgtvdefsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehjihhkohhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlrg
    hrshesmhgvthgrfhhoohdruggvpdhrtghpthhtoheplhhinhhugidqihhiohesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhinhhpuhhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xW6FZ_7M_Ds_wL0a2fdD69QLZw-9MIfVvOjrOrvvAGvNPYWKowkf_w>
    <xmx:xW6FZ03o2i3vCcCCXEq8Fj8YbF_G5dsMk5fN7R1VkV9FLJiLke6ZZw>
    <xmx:xW6FZyHbKVwB6JnFCD_CeKgOWNE4a0n_8rilcJYJrN-nyO5BcrUcWw>
    <xmx:xW6FZ1-PBPoJFiFHhqXX7vWEG0An3dG63tFwgGuCKnVo20f27evP0w>
    <xmx:xW6FZwbxkI-PIFqIPsRW_d8ir8s4vgFP9niUgX_YWR_w0AGIzmlrpY7R>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 17ACF3C0068; Mon, 13 Jan 2025 14:51:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 Jan 2025 14:49:59 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: Srinivas <srinivas.pandruvada@intel.com>, ribalda@chromium.org,
 jic23@kernel.org
Cc: jikos@kernel.org, linux-input@vger.kernel.org,
 Jonathan.Cameron@huawei.com, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <8fed2747-c419-454a-bb72-43f158b4f081@app.fastmail.com>
In-Reply-To: 
 <TYZPR03MB599406F8035E6322E6B66CBFBD1F2@TYZPR03MB5994.apcprd03.prod.outlook.com>
References: <20241216-fix-hid-sensor-v2-1-ff8c1959ec4a@chromium.org>
 <20241219171718.2af17d6d@jic23-huawei>
 <CANiDSCvkKX68UqSuKiGiys8nwm5BX-FbKmHPtxJK=Hh=B4RqZQ@mail.gmail.com>
 <45ae61a978e7d4ea34502604a6d508f14c29303b.camel@intel.com>
 <TYZPR03MB599406F8035E6322E6B66CBFBD1F2@TYZPR03MB5994.apcprd03.prod.outlook.com>
Subject: Re: [PATCH v2] iio: hid-sensor-prox: Split difference from multiple channels
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Note - switched to my open-source friendly email account (avoid the Lenovo address, especially for mailing lists, it's Outlook based and can't cope).

On Mon, Jan 13, 2025, at 2:19 PM, Mark Pearson wrote:
> Subject: [External] Re: [PATCH v2] iio: hid-sensor-prox: Split 
> difference from multiple channels
>
> On Sat, 2025-01-11 at 10:17 +0100, Ricardo Ribalda wrote:
>> Hi Jonathan
>>
>> Happy new year!
>>
>> Friendly ping about this patch so we can change the ABI before the
>> kernel release happens
>>
>> On Thu, 19 Dec 2024 at 18:17, Jonathan Cameron <jic23@kernel.org>
>> wrote:
>> >
>> > On Mon, 16 Dec 2024 10:05:53 +0000
>> > Ricardo Ribalda <ribalda@chromium.org> wrote:
>> >
>> > > When the driver was originally created, it was decided that
>> > > sampling_frequency and hysteresis would be shared_per_type
>> > > instead
>> > > of shared_by_all (even though it is internally shared by all).
>> > > Eg:
>> > > in_proximity_raw
>> > > in_proximity_sampling_frequency
>> > >
>> > > When we introduced support for more channels, we continued with
>> > > shared_by_type which. Eg:
>> > > in_proximity0_raw
>> > > in_proximity1_raw
>> > > in_proximity_sampling_frequency
>> > > in_attention_raw
>> > > in_attention_sampling_frequency
>> > >
>> > > Ideally we should change to shared_by_all, but it is not an
>> > > option,
>> > > because the current naming has been a stablished ABI by now.
>> > > Luckily we
>> > > can use separate instead. That will be more consistent:
>> > > in_proximity0_raw
>> > > in_proximity0_sampling_frequency
>> > > in_proximity1_raw
>> > > in_proximity1_sampling_frequency
>> > > in_attention_raw
>> > > in_attention_sampling_frequency
>> > >
>> > > Fixes: 596ef5cf654b ("iio: hid-sensor-prox: Add support for more
>> > > channels")
>> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>> >
>> > I got lost somewhere in the discussion.  This is still an ABI
>> > change compared
>> > to original interface at the top (which is the one that has been
>> > there
>> > quite some time).
>> >
>> > However we already had to make one of those to add the index that
>> > wasn't there
>> > for _raw. (I'd missed that in earlier discussion - thanks for
>> > laying out the
>> > steps here!)
>
> Didn't realize this. I don't see proximity sensor use in the mainline
> Linux distro user space, so it will affect only some private user space
> programs.
> Adding Mark to see if it affects Lenovo Sensing solution as there was
> specific custom sensor added to this driver for Lenovo.
>

Can I get some pointers to what sensor that is please?
We've been asking for the HID support drivers, but it isn't available yet to my knowledge. Would the MIPI camera work tie into this?

If I can get details on what the sensor is I'll go and check what is impacted.

Thanks
Mark

