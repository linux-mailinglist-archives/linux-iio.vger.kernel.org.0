Return-Path: <linux-iio+bounces-22350-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC63B1CB8C
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 20:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7FE818C37AD
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 18:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2881EBA07;
	Wed,  6 Aug 2025 18:00:18 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4349E1D7E26
	for <linux-iio@vger.kernel.org>; Wed,  6 Aug 2025 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754503218; cv=none; b=guMY6l72LvwVSZbKLAKxbahtguUQ9QJmg94jxlyQiaOoAR9lRSfThz56y9w5hj2b+mi5Y31xyycQ4LbyZYwMbJgAs5DqpLKtmorMpNOHIBgHYlN8chcRFhiQegPiggZDkhNeIYR4Y6xoRIpkdZrbv6mek6IOIECP+gQTL9wod6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754503218; c=relaxed/simple;
	bh=jsLLi83jiDWzEkyYivOSXWimk/swDG6qKldqqHPjEqA=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type; b=JGo5yURjU+0cLsAYeRtm46hAjfQKttdcfOg7w0ltrIQik5Mu14aFKS0GwXyGW1t9ESDJLcoYISuqtyaa6RRNKDgoJuKvNhPjNYbI9xmjYE3rh7ZEixvWBgad31RCr3vp+VcakQqh8SCRDq4DWdJ3McaRaR4lfLcUoSi9u0x44ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glki-linux-iio@m.gmane-mx.org>)
	id 1ujiQw-0001kG-LJ
	for linux-iio@vger.kernel.org; Wed, 06 Aug 2025 20:00:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: linux-iio@vger.kernel.org
From: ASSI <Stromeko@nexgo.de>
Subject: Re: [bmp280 v1 2/6] iio: pressure: bmp280: reduce overhead on read with MODE_FORCED
Date: Wed, 06 Aug 2025 20:00:09 +0200
Organization: Linux Private Site
Message-ID: <87a54cmity.fsf@Gerda.invalid>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250803140802.36888-1-Achim.Gratz@Stromeko.DE>
	<20250803140802.36888-3-Achim.Gratz@Stromeko.DE>
	<20250806165859.000039d4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:WZfKNydNPfrz2LQJBDXlhlijOkk=

Jonathan Cameron writes:
> On Sun,  3 Aug 2025 16:07:58 +0200
> Achim Gratz <Achim.Gratz@Stromeko.DE> wrote:
>
>> When measuring with MODE_FORCED, each read through sysfs triggers a
>> new measurement cycle through aLL channels with the current channel
>> configuration, even though we can only access a single channel.
>> Reduce the incurred overhead (especially for higher oversampling_ratio
>> settings) by temporarily switching off the unused channels.  This
>> savea about a third of the acquisition time when reading all three
>> channels in succession:
>> 
>> | oversampling | max/full | max/skip | time/full | time/skip |
>> |              |     [ms] |     [ms] |      [ms] |      [ms] |
>> |--------------+----------+----------+-----------+-----------|
>> |           16 |      339 |      120 |       315 |       127 |
>> |            8 |      174 |       65 |       166 |        76 |
>> |            4 |       90 |       38 |        94 |        53 |
>> |            2 |       49 |       24 |        59 |        41 |
>> |            1 |       28 |       17 |        36 |        33 |
>> 
>> The results are from an I²C connected sensor at 400kHz, so there is
>> considerable overhead from the changing the channel configuration,
>> most noticeably with low oversampling_ratio values.  Faster
>> communication will reduce this overhead further; and since there is
>> still a net reduction in acquisition time even for
>> oversampling_ratio=1 switching off the channels is always done.
>> 
>> Note: The IIR filters will process a slightly noisier input signal.
>> 
>> Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
> Hi Achim.
>
> I'm not really sure what the algorithm implemented here is and what the
> various local variables actually mean as state.  Please add some
> more comments to the code.

Based on yours and Andys comment I'm currently inclined to abandon this
part of the series and just let anybody still using the MODE_FORCED
operation suffer from the overly long acquisition cycles when using the
sysfs interface.

> Maybe worth factoring out he contents of the switch case that has goto restore
> into a separate function so that the scope of the restore is same as the code
> that is calling it.  (i.e. avoid a goto jumping out of a switch.

I'll think about that when I have decided whether to keep that
feature in the code.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+


