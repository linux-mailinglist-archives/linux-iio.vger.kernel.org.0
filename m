Return-Path: <linux-iio+bounces-10541-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198E999BBDB
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2024 22:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69CD5B20B41
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2024 20:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7041494C2;
	Sun, 13 Oct 2024 20:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="B5ph5/YN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GpvMgpVF"
X-Original-To: linux-iio@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD362AF1E;
	Sun, 13 Oct 2024 20:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728852942; cv=none; b=pTMXS6xv2QZ8u2VtlxkIpmkKRfXdphAEtncLOc+1tXyTHp8eMQ3X9ip5L7SkMR7nS7Fb1bwQ6HdIBEJbe3BJtrGvmdAfpoqb5oTCgRoSpVriPdZWlW1CujSuupUgSzRxfNwhlMJtr0kK0jF8uWbCxG9dvuWraFCxwuEo+u3nGYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728852942; c=relaxed/simple;
	bh=Q1GrcF2/nJ5z3u0ixp2goeMuH/5d1nOsniH15D+Q5Kc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fbb+kyQM8vB28qPF2vEs+6L8e+BSCC4jJun0mRbyooxqjXBqu0xjfVZn3F5CLE019+LqCOtkxUjt+QYCzP1tG5pMR3OLL0m4pbd8Z/p4dUswuJy6Ke/72xP1YHLlfLlq3Nc/+gGpQJggXhBiInh+CuzvJFuMsPh0BTBUWleEfNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=B5ph5/YN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GpvMgpVF; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ABEF32540086;
	Sun, 13 Oct 2024 16:55:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 13 Oct 2024 16:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1728852938; x=
	1728939338; bh=s3WgEFYsiZJSsuGIMld6sGl7mrDKMb4L+PA/mhWrZoY=; b=B
	5ph5/YNDxZsWlj9ph0IUOUSTiiwhrT0BCHDQKKAbC87ImCb86XSD9DK32MSgpjRk
	ThMXOt7dHR8/IIm+zDuUMTJsYn87UPXurMWKku/LNd/+82PvoqvzQWe2xLBw9MCk
	6CkygU0F+vVdhJ/NVupw0noGK674cr0QbPA24rDLbJqelUpZCu3IGIwL8gG/7gkk
	/7gVgmf0rjp2fz1wGROD4je3XemiKYLMrjRlXhxyqtchgWYsOhqodFJDOY1D2Ksq
	MdHCjNGc0pfDzCiB3HAE4AY9BVYRFeiObeHcRHEKMy6IhcAKeHxgcX156tQccKW+
	OLr/Z9IQAl/uzYk+CsRgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728852938; x=1728939338; bh=s3WgEFYsiZJSsuGIMld6sGl7mrDK
	Mb4L+PA/mhWrZoY=; b=GpvMgpVF+x0rqQyNyMWarVDcMgxN3xvovbi6OJH4B9FO
	ghVq7QQq14LKGhCIaM0QwivucBnl8wBEQaisNkq/Zcmgjeg9BkLrT8mFg8L6F2Zm
	nZZjnkDipshUAElgVzBpyrvDHQ6G0BgMNa0qRfvwtp17T3D3Ch6uvCmWXMeMXYzQ
	B1MBwaEvEbAuP6s6G/lcjBEQ2B+HRIWudDD3HShGen+JabhVGrlLHv3xPDS0PyFZ
	O8x8YN1AFR7f05LYMKhSo+mwRo7BEnExzePdIZR0mZ5nr3GlSMzkVbVKNQY8JGJC
	m6BrLOX16IjrX7URCYuWbqHbK3qojKuQWVkjTb+vmg==
X-ME-Sender: <xms:yjMMZxrI4owN4w4TzQOqqe4zrIAalKB9KAdqZKDxuAEi05SroOXrzA>
    <xme:yjMMZzqrRAiBx6wDLzS24ry5hZI706rKQiDcu44stVyU3zMpe4b2tOMtYnUIrKm3y
    6hqTG2sdRq8ilnJFA>
X-ME-Received: <xmr:yjMMZ-Nb61Ni3gUdZNUfzs0pr5uFABbMFYMVPF7Yo-lP7mWsmjLlE1ijKMhHwWHbFyl1BZpCdP3QikhFtZuGsCok0CwwaK6_daA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegfedgudehkecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:yjMMZ8596wOR_Z-zb76YtjZhtFAkbG1ssLtlVKaFoTlttrSj7PTVTA>
    <xmx:yjMMZw5pdxgCBlFJ6zQz1Y7Sg4J1kvYrqQ6VQWIExqWpB3JQxl7YJQ>
    <xmx:yjMMZ0jrCDFfJ0sT6oVyHEjgATYvYcj1u2miL0wkUbssoquV6WJwtw>
    <xmx:yjMMZy5vLK3qE1496P_VA25gRXxQYfx4JcmsVgXmJxyljJM0uldr6Q>
    <xmx:yjMMZ_Z3d-uCsv6xqIwCMV98gnO5OOLt_rC2lgGRO6E_UZKHwK_4U4C6>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Oct 2024 16:55:37 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,  Lars-Peter Clausen
 <lars@metafoo.de>,  linux-iio@vger.kernel.org,
  linux-kernel@vger.kernel.org,  "Derek J . Clark"
 <derekjohn.clark@gmail.com>,  Philip =?utf-8?Q?M=C3=BCller?=
 <philm@manjaro.org>
Subject: Re: [PATCH 3/3] iio: imu: Add scale and sampling frequency to
 BMI270 IMU
In-Reply-To: <20241013164000.19087833@jic23-huawei> (Jonathan Cameron's
	message of "Sun, 13 Oct 2024 16:40:00 +0100")
References: <20241011153751.65152-1-justin@justinweiss.com>
	<20241011153751.65152-4-justin@justinweiss.com>
	<20241012123535.1abe63bd@jic23-huawei> <87jzecpvpd.fsf@justinweiss.com>
	<20241013164000.19087833@jic23-huawei>
Date: Sun, 13 Oct 2024 13:55:36 -0700
Message-ID: <87ttdfn2nr.fsf@justinweiss.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Cameron <jic23@kernel.org> writes:

> On Sat, 12 Oct 2024 19:45:18 -0700
> Justin Weiss <justin@justinweiss.com> wrote:
>
>> Jonathan Cameron <jic23@kernel.org> writes:
>> 
>> > On Fri, 11 Oct 2024 08:37:49 -0700
>> > Justin Weiss <justin@justinweiss.com> wrote:
>> >  
>> >> Add read and write functions and create _available entries. Use
>> >> IIO_CHAN_INFO_SAMP_FREQ instead of IIO_CHAN_INFO_FREQUENCY to match
>> >> the BMI160 / BMI323 drivers.  
>> >
>> > Ah.  Please break dropping _FREQUENCY change out as a separate fix
>> > with fixes tag etc and drag it to start of the patch. It was never
>> > wired to anything anyway
>> >
>> > That's a straight forward ABI bug so we want that to land ahead
>> > of the rest of the series.  
>> 
>> Thanks, I'll pull that into its own change and make it the first patch.
>> 
>> > Does this device have a data ready interrupt and if so what affect
>> > do the different ODRs for each type of sensor have on that?
>> > If there are separate data ready signals, you probably want to 
>> > go with a dual buffer setup from the start as it is hard to unwind
>> > that later.  
>> 
>> It has data ready interrupts for both accelerometer and gyroscope and a
>> FIFO interrupt. I had held off on interrupts to keep this change
>> simpler, but if it's a better idea to get it in earlier, I can add it
>> alongside the triggered buffer change.
>
> Ok. So the challenge is that IIO buffers are only described by external
> metadata.  We don't carry tags within them.  Hence if you are using
> either effectively separate datastreams (the two data ready interrupts)
> or a fifo that is tagged data (how this difference of speed is normally handled
> if it's one buffer) then when we push them into IIO buffers, they have
> to go into separate buffers.
>
> In older drivers this was done via the heavy weight option of registering
> two separate IIO devices. Today we have the ability to support multiple buffers
> in one driver. I'm not sure we've yet used it for this case, so I think
> there may still be some gaps around triggering that will matter for the
> separate dataready interrupt case (fifo is fine as no trigger involved).
> Looking again at that code, it looks like there may need to be quite
> a bit more work to cover this case proeprly.
>
> We may be able to have a migration path from the simple case you have
> (where timing is an external trigger) to multiple buffers.
> It would involve:
> 1) Initial solution where the frequencies must match if the fifo is in use.
>    Non fifo trigger from data ready might work but we'd need to figure out
>    if they run in close enough timing.
> 2) Solution where we add a second buffer and if the channels are enabled
>    in that we can allow separate timing for the two sensor types.
>
> This is one of those hardware features that seems like a good idea
> from the hardware design point of view but assumes a very specific
> sort of software model :(
>
> Jonathan

Hm, that does sound tricky. If there's an example I can follow, I can
make an attempt at it. Otherwise, if there's a change I can make now
that would help with migrating in the future, I can do that instead.

Of the devices I've looked at, only one has had the interrupts usable
and that one only had a single pin available. So if this change doesn't
make it harder to add later if it's necessary, I would still be OK going
without full support for now.

Justin

