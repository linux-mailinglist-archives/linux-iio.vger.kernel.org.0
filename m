Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245FE458D35
	for <lists+linux-iio@lfdr.de>; Mon, 22 Nov 2021 12:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbhKVLUs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Nov 2021 06:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236419AbhKVLUr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Nov 2021 06:20:47 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D00C061574
        for <linux-iio@vger.kernel.org>; Mon, 22 Nov 2021 03:17:40 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id n12so79122890lfe.1
        for <linux-iio@vger.kernel.org>; Mon, 22 Nov 2021 03:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Dkx0MUSWm0/HiS+F3NFCxyYWLWk3gc8tkuA/thO1Wts=;
        b=zsuyJqBsCCRI+kyI+cAlne1apGSUoTSjcpRwrQzjGYOxcS2V6z7Ajlw5r7C50qVPtk
         twb1Lfrkj7Txe7EQK5BfuKcw/O7gTyF0YMqZvO62vQTIrZR0tXkDeDVgmretFZ7wwmcO
         8ZhhaTx9PdHwuVR8ZcIBXzFiBPUmxfszkWtoXtajlP75b/KzULEMUOe2SkmbESy8dFpa
         IHejibuhFJw6e8B/UDEVMax1UGbfmHxdQFuiCXwHoTdCVQ4IMdz234pVkRITl1V1B69W
         0v/Wg+cVWdpE7gvSPQkEngBwduBCKLsf6OTIYcOWDEnOsc6S0jj8ra0RNqrvALOHv1sP
         QKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Dkx0MUSWm0/HiS+F3NFCxyYWLWk3gc8tkuA/thO1Wts=;
        b=DCDff55T3pqc5nkJAq37NJSSE9DM0O5GIKD1I8oUXtv9XPik+mQ7bOMoQF3c9L7lVI
         DPn14UqDibdesd8Fkmruf4PAhOHt4rAk78Ae/oNQJJ49Pgc9+oFrlX7Qrak2Plrtmihs
         Wf7jlhHZF53BrxIcHq+dfSQqf7uBSlvczooFfIOk0eMq3zdEy0EYSGVnjVcT9vUXR0mx
         nSBtHtm9AEIRABrS7GOvjzLqJ+O4kDAkbXnRyAxyZayhUVI3vnzk38D2Zc1rx/89FgA9
         1+iQY9jWRhqa4hFmnK/DP++yJfE9oT/Z+5667mpKLUEXluVzKhaa8FxWTH4X3gCKhFjx
         qXoQ==
X-Gm-Message-State: AOAM5303MfRSXzkDs4j6fcHlSgvkwepWmOaMGDqn3spBPaWvyO8IlGgn
        L1GzDcYPGIafxz0DLAoCf5+OnduFdftElA==
X-Google-Smtp-Source: ABdhPJy8WK37v2EIorSjH7f5lkHs9whG2eHW5P4949bVrxmWUE0NBaA3HsSGEh3j0H/xK0co6ai4KA==
X-Received: by 2002:a2e:9107:: with SMTP id m7mr49560782ljg.209.1637579858969;
        Mon, 22 Nov 2021 03:17:38 -0800 (PST)
Received: from [192.168.1.213] (81.5.99.121.dhcp.mipt-telecom.ru. [81.5.99.121])
        by smtp.googlemail.com with ESMTPSA id x133sm929333lff.282.2021.11.22.03.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 03:17:38 -0800 (PST)
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: document TS voltage in AXP
 PMICs
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Quentin Schulz <foss@0leil.net>, linux-sunxi@lists.linux.dev
References: <20211118141233.247907-1-boger@wirenboard.com>
 <20211118141233.247907-3-boger@wirenboard.com>
 <20211122104915.zism6uadgwxjz5d2@gilmour>
From:   Evgeny Boger <boger@wirenboard.com>
Message-ID: <d1a18116-e198-1b26-d73a-36fbf31aaa81@wirenboard.com>
Date:   Mon, 22 Nov 2021 14:17:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211122104915.zism6uadgwxjz5d2@gilmour>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

22.11.2021 13:49, Maxime Ripard пишет:
> On Thu, Nov 18, 2021 at 05:12:33PM +0300, Evgeny Boger wrote:
>> Most AXPxxx-based reference designs place a 10k NTC thermistor on a
>> TS pin. axp20x IIO driver now report the voltage of this pin via
>> additional IIO channel. Add new "ts_v" channel to the channel description.
>>
>> Signed-off-by: Evgeny Boger <boger@wirenboard.com>
> Would it make sense to put the resistance in the DT as well or is it
> made mandatory by Allwinner?
>
> Maxime
Well, I don't think so. Basically, by default AXP20x injects 80uA current
into the TS pin and measure the voltage. Then, there are voltage thresholds
to stop charging if the battery is too hot or too cold. The default 
thresholds
were calculated by the manufacturer for default 10k resistance and 80uA 
current.
Finally, if TS pin isshorted to GND, the AXP2xx will detect it and won't 
shut

down charging.
Note that AXP2xx doesn't convert the measured voltage to temperature.

So while it's possible to use AXP2xx with resistance other than 10k, it will
require us to override these protection thresholds. Moreover, if one 
want to
put the actual resistance in DT, then the driver would need to calculate 
these
protection thresholds based on NTC parameters and injection current.
I think we better keep things simple and let DT followthe hardware, 
which only
operates in terms of voltage, not temperature and resistance.

-- 

