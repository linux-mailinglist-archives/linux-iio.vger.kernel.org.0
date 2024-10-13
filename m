Return-Path: <linux-iio+bounces-10540-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D525299BBD8
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2024 22:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7BE1F2146D
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2024 20:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13DE1494C2;
	Sun, 13 Oct 2024 20:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="KZWL+4vY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kQaXttxT"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6720E7F48C;
	Sun, 13 Oct 2024 20:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728852881; cv=none; b=iAb8p/k8LoTthqshFpwORRqmUMAmAqChgDQQwpxG/tKMNzuFxxs9kZ4vTZmBW9ROoazdYjD56kR1kq1udhtgl72eHMpZ/L0mtq3OCUJ+lad3HCyrwU2kLEJsNHkJM3xpsp3Ok5Dc5rSZJaXCR1bV0xv0xXIQjeUhuJcqKFN1rmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728852881; c=relaxed/simple;
	bh=M7gTMe+DdMPfiS1JJPCwU3M7I8yOxF1tunz8X2MP3xY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QoqOoGpf079MAW7wyghAE75+R5/nziGRpYcUuGwyRgwScmLNdheyifaDPCpoNq9NUl6ViV2J1HBeZhNI6n0IfBlb7Jfgx1BLNf0w7AtDDsi7mY7GHdXmyVz8L8FUeBtvnc9Q50i5lMLnIiUPGPCkyZ7yBaSccRFJ/jxBPuJcWJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=KZWL+4vY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kQaXttxT; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4045B114008A;
	Sun, 13 Oct 2024 16:54:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 13 Oct 2024 16:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1728852878; x=
	1728939278; bh=a0VRRTy8X2sms4uVNAra4nk90Lep85Ne8hWt5wH9dlU=; b=K
	ZWL+4vYca9PDx7J5mcKuIQ455UCx9aVHsqaAh0QW9jBu0t0R47pKEhtU4n0U7o1f
	fAetUn1GvCHKNt+WN6WIrEBde4AWwGhlAPQu+pTSqLK4EiJttVfLa6CjkbtMY0v2
	r6bj5bkcNIleSLZJCWBuJQWjeYkLcKvcinxLqD1XQWgLG/s5o8SsWxLBZsgSp3Oi
	to3a6gwEGI2lRlMDiZo+gVQGdfrQ0HvG0o//NGjZ1gcKhv1RbEY0kOLmctLxkZ6C
	mkLVFyB+6V9AaP7H+TbCw3dwLuJEeaBkHlx2UpAgeKPG9/fSq/WbwrofYRvqWW9C
	HzZsewOkZaW7fMoEnqhRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728852878; x=1728939278; bh=a0VRRTy8X2sms4uVNAra4nk90Lep
	85Ne8hWt5wH9dlU=; b=kQaXttxT/iHkqu5DE/+KkgI3paiYEFPFnOD0YhERreDq
	iXMy4FlKyFGfA/IqZa1ZqU5UYAiWmc5OBFaGRGSOhHRacTyWf7K+XKqoY/XvRGUd
	bkCOjEAq9BFkksM302Mz3ktBXfd1mZWseFnm4kQpaZQbYNK1yoo+qWE7SLNs6Hbp
	sZh+vOczkdMn/IPLzwep+Ut6Nl66y4vs/ckmP+e689hpD7VO3iF0m5vGvK9ua1wD
	GoNq+5+5swIGJxtnZvkoPNatUy3QYeRi0I6Y/lWVwXjFN8/8UggzOCSI8VKyzv1m
	osbH+EsOC5vaifG3VLVB5CpOvLt9uWwQ3lC9DX6JYg==
X-ME-Sender: <xms:jTMMZwev6jXQWlFaBNzdym79_ta0fxkcWtPubHqkrv33IwURYnCj0g>
    <xme:jTMMZyPsloKvkez_EBFoOzD2uuCRunklHcypvQNWrOKsrKuDaHRFpBuYzM8Ap3gl7
    BfqHmU7OEa2e6UwxA>
X-ME-Received: <xmr:jTMMZxhVDjS3EHaoiqQdz7WAwgemMFAW-b-AMqePmjyGzNrboMhNtyoFZ_yQf4fwFCV_GZ-23bBMzMAsn_gM6z7h5za0_1Bl-JU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegfedgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhsthhinhcuhggvihhsshcuoehjuhhsthhinhesjhhushhtihhnfi
    gvihhsshdrtghomheqnecuggftrfgrthhtvghrnhepgfeugeeuieehffekkedtteffgfff
    ueeikedvfeeijedvfeeigfevhfeihfefgfevnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepjhhushhtihhnsehjuhhsthhinhifvghishhsrdgt
    ohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hphhhilhhmsehmrghnjhgrrhhordhorhhgpdhrtghpthhtohepuggvrhgvkhhjohhhnhdr
    tghlrghrkhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhiihhosehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgrrhhssehmvghtrghfohhord
    guvgdprhgtphhtthhopehlrghniigrnhhordgrlhgvgiesghhmrghilhdrtghomhdprhgt
    phhtthhopehjihgtvdefsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jTMMZ183kZFnyALTlm7WLbvYW6bDIVNKPZ6hYwxkChQoK41RcHmqhw>
    <xmx:jTMMZ8uxaxzpa-ZXC-2t5LChZJfkB_6W8XkkBwxF1OyQJZiyPWDp5w>
    <xmx:jTMMZ8GxoU3En35AWCINdhYhCcQ9Ndrn4p9H1Kbc2kav0s16KZvuUA>
    <xmx:jTMMZ7OmFQJoBPq6lqwltdyGXLz5-u9tH0U6p9qTvnezsYHpRGXYnQ>
    <xmx:jjMMZx_Fb2jCt-w3LY64BYL5oEU2ZXeYa3GgFL3F6zP9I8Phb20sLzbu>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Oct 2024 16:54:36 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,  Lars-Peter Clausen
 <lars@metafoo.de>,  linux-iio@vger.kernel.org,
  linux-kernel@vger.kernel.org,  "Derek J . Clark"
 <derekjohn.clark@gmail.com>,  Philip =?utf-8?Q?M=C3=BCller?=
 <philm@manjaro.org>
Subject: Re: [PATCH 2/3] iio: imu: Add triggered buffer for Bosch BMI270 IMU
In-Reply-To: <20241013161722.5cb25eb3@jic23-huawei> (Jonathan Cameron's
	message of "Sun, 13 Oct 2024 16:17:22 +0100")
References: <20241011153751.65152-1-justin@justinweiss.com>
	<20241011153751.65152-3-justin@justinweiss.com>
	<20241012121812.0c62ba51@jic23-huawei> <87wmicpvso.fsf@justinweiss.com>
	<20241013161722.5cb25eb3@jic23-huawei>
Date: Sun, 13 Oct 2024 13:54:36 -0700
Message-ID: <871q0joh9v.fsf@justinweiss.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Cameron <jic23@kernel.org> writes:

> On Sat, 12 Oct 2024 19:43:19 -0700
> Justin Weiss <justin@justinweiss.com> wrote:
>
>> Jonathan Cameron <jic23@kernel.org> writes:
>> 
>> > On Fri, 11 Oct 2024 08:37:48 -0700
>> > Justin Weiss <justin@justinweiss.com> wrote:
>> >  
>> >> Set up a triggered buffer for the accel and angl_vel values.
>> >> 
>> >> Signed-off-by: Justin Weiss <justin@justinweiss.com>  
>> > Hi Justin
>> >
>> > A few suggestions inline. Other than the DMA safe buffer thing, looks good
>> > but you might want to consider using a single bulk read.
>> >
>> > My cynical view is that if someone paid for an IMU they probably want all
>> > the channels, so optimizing for that case is a good plan.
>> >  
>> >> ...
>> >> 
>> >> +	__le16 sample;
>> >> +
>> >> +	for_each_set_bit(i, indio_dev->active_scan_mask, indio_dev->masklength) {
>> >> +		ret = regmap_bulk_read(bmi270_device->regmap,
>> >> +				       base + i * sizeof(sample),
>> >> +				       &sample, sizeof(sample));  
>> >
>> > This is always a fun corner.
>> > regmap doesn't guarantee to bounce buffer the data used by the underlying
>> > transport. In the case of SPI that means we need a DMA safe buffer for bulk
>> > accesses.  In practice it may well bounce the data today but there are optmizations
>> > that would make it zero copy that might get applied in future.
>> >
>> > Easiest way to do that is put your sample variable in the iio_priv structure
>> > at the end and mark it __aligned(IIO_DMA_MINALIGN)
>> >
>> > Given you are reading a bunch of contiguous registers here it may well make
>> > sense to do a single bulk read directly into buf and then use
>> > the available_scan_masks to let the IIO core know it always gets a full set
>> > of samples. Then if the user selects a subset the IIO core will reorganize
>> > the data that they get presented with.  
>> 
>> That's convenient :-)
>> 
>> It should make this much simpler. To clarify, I'll use regmap_bulk_read
>> to read all of the registers at once into a stack-allocated buffer, and
>> then push that buffer. Then I can remove bmi270_device->buf entirely,
>> and avoid the DMA problem that way.
>
> Given this supports SPI. The target buffer can't be on the stack.
> You still need the __aligned(IIO_DMA_MINALIGN) element in your iio_priv()
> structure.
>

Got it. I see that the BMI323 driver does the regmap_read into the
DMA-aligned buffer, and then copies it to the timestamp-aligned buffer,
which it then sends to iio_push_to_buffers_with_timestamp. Is that a
good way to handle this?

I think the timestamp-aligned buffer could still be stack-allocated in
that case. Or maybe a second buffer isn't even necessary, if
DMA_MINALIGN is at least the correct alignment for
iio_push_to_buffers_with_timestamp and I could pass the DMA-aligned
buffer in.

Justin

>> 
>> Then I'll provide one avail_mask that sets all of the
>> BMI270_SCAN_ACCEL_* and BMI270_SCAN_GYRO_* bits.
> Otherwise your description is what I'd expect to see.
>
>> 
>> > Whether that makes sense from a performance point of view depends on
>> > the speed of the spi transfers vs the cost of setting up the individual ones.
>> >
>> > You could optimize contiguous reads in here, but probably not worth that
>> > complexity.
>> >  
>> >> +		if (ret)
>> >> +			goto done;
>> >> +		bmi270_device->buf[j++] = sample;  
>> >
>> > It's not a huge buffer and you aren't DMAing into it, so maybe just put this
>> > on the stack?
> This would only be correct for the case where you aren't DMAing directly into it.
> I guess I confused the message above with this point!
>
> Jonathan
>
>> >  
>> >> +	}
>> >> +
>> >> +	iio_push_to_buffers_with_timestamp(indio_dev, bmi270_device->buf, pf->timestamp);
>> >> +done:
>> >> +	iio_trigger_notify_done(indio_dev->trig);
>> >> +	return IRQ_HANDLED;
>> >> +}  

