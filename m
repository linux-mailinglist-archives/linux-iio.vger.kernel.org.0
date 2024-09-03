Return-Path: <linux-iio+bounces-9080-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32F196A410
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 18:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC105B22806
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 16:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9B218B486;
	Tue,  3 Sep 2024 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vxVZ+v3T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C16518858C
	for <linux-iio@vger.kernel.org>; Tue,  3 Sep 2024 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725380249; cv=none; b=P4vmn7qHuYXTh3iIMCSHPbKSb0U/DShghSWY+chhWYnh8PHYiuhkGTRf0iu4HcTNqXTbK03cjnJR7hFcf+dQSYZkq7kY8HhOVBSQIPMlSwOHTIuw5kbLtYfJZQzhYBRekFGTxtM8XUEf55MH2KOGtri0IYSAoBsuDtd+LfeklJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725380249; c=relaxed/simple;
	bh=QUrDmjGxDWVKFhcNoy+HxAmj0c8osU6YyWrVQMdtj1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=acPZB1dTA6rw9jWjDl+OTQpd8Tu4g1ezc9IT4sXvBH8KwL8JuMwU5uXUqhvHpc0U4fUWcRoh35DmhyMmvIugcEhYzWhOYRaDHhHOvfP2mcYjP3LK/zc+KVILzkcKbGhiqDzvmMjb6bUGDROX/SbgH9czYWnknWAiDoDcbqlb1mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vxVZ+v3T; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7093ba310b0so2320758a34.2
        for <linux-iio@vger.kernel.org>; Tue, 03 Sep 2024 09:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725380246; x=1725985046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=53GiOZpe/Mi1YNWuIB9EhTKXzBDKqq6MqraEG6tJCLo=;
        b=vxVZ+v3TwtDPT8w9+afpdOjiOGpM1Y1AkdGzRLtBB19QBo/1OFxKowXzOJNoUmyRxL
         yd7RLz9I52TSVvygBytT5/tpR6TGCQTdS442PgXfbsA2PCIgzD+hi5HE8DhXI2OrwnnP
         LuR8V7OVqGMdvBE9z+NmWasqR1uJxbgeupXNSn5vFGL4jiDIs5/kZh26BEz+EmhfELQd
         RG7WOfsSevRw7KvJrxeeryDcglWp3NHfmnW1p55SxhFYG8oVyDB0BevwXgi4ZLumx89o
         xrMag5qBcGNGiglA/U5xPgTK5m5q10vWCoMbUZUwQeNhyKJtU7a3e6IvPvUrWIRP/R0T
         pPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725380246; x=1725985046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=53GiOZpe/Mi1YNWuIB9EhTKXzBDKqq6MqraEG6tJCLo=;
        b=GSMdlubOCN/q8O7BnU7Q8YI8ljeHr5a+CXWQ0KEwjk7l33s6AMxnE1Dmg7S15orjl8
         aHq1wJgwQbZ36qgjyj53Uoa0LV6pW6i0DTQ0SQLsdeklg3eegt92T3RbAKbHoIjjh7TX
         1ZSluJMzYAlkLsrOEeYpzCfUr+YNfRVWqzORczXDBIigJB6rb0fWA++NoBvGHL10ilya
         0d8Ckjchcuh8oyHepUcQz3FWGlwZk8I95+tJLvxEiltsBhA6tibcfuQN+E992/qFef0X
         5Y7lzOKZ26sBru/cFAH5u6XZqzydlKvuPCudglZVz4PAyTv1ZG5DflMBvqNm99Dh29Ei
         aM4A==
X-Forwarded-Encrypted: i=1; AJvYcCW+y9afmc3skXL9isMyvIrWgghcLtsQA+nRSLmHcuC6FOhjlytkK1FPuroxjqo/PpnNPuwY6fksiTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSCbEOs9raldLeZVJGlHF5mrNIHZU2z5ehg+OTUUlnLFkbC9+x
	B14vXVaonpTgWNM+S879MXwh3eRpw0WLznVC+a/Qs9OF0AMDdJfXi2wKOaxaaXc=
X-Google-Smtp-Source: AGHT+IHTlOQ2HrzrTU2Q3N454srcRMdp7zFoL+AYKDmUWAD5RYsVkxQj4bH6We19C8bVDozpvH490g==
X-Received: by 2002:a05:6830:dc8:b0:70c:92ee:5662 with SMTP id 46e09a7af769-70f71efed69mr13403446a34.8.1725380246297;
        Tue, 03 Sep 2024 09:17:26 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70f671a82a0sm2413574a34.60.2024.09.03.09.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 09:17:25 -0700 (PDT)
Message-ID: <4a62ea7b-a8af-49e0-9718-30d927a69038@baylibre.com>
Date: Tue, 3 Sep 2024 11:17:24 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/8] iio: dac: introducing ad3552r-axi
To: Angelo Dureghello <adureghello@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
 <20240831123837.26a1070a@jic23-huawei>
 <74e0b200-d4c0-4aa3-9ee6-f49ac3f1467d@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <74e0b200-d4c0-4aa3-9ee6-f49ac3f1467d@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/3/24 3:34 AM, Angelo Dureghello wrote:
> Hi Jonathan and all,
> 
> 
> On 31/08/24 1:38 PM, Jonathan Cameron wrote:
>> On Thu, 29 Aug 2024 14:31:58 +0200
>> Angelo Dureghello <adureghello@baylibre.com> wrote:
>>
>>> Hi, asking for comments for this patchset, that is mostly
>>> ready, at least feature-complete and functionally tested.
>>>
>>> I am introducing ad3552r-axi variant, controlled from a fpga-based
>>> AXI IP, as a platform driver, using the DAC backend. The patchset is
>>> actually based on linux-iio, since some needed DAC backend features
>>> was already there on that repo only, still to be merged in mainline.
>>>
>>> Comments i would like to ask are:
>>>
>>> - i added some devicetree bindings inside current ad3552r yaml,
>>>    device is the same, so i wouldn't create a different yaml file.
>> Agreed. If same device, it's usually better to keep it in one file.
>>
>>> - if it's ok adding the bus-type property in the DAC backend:
>>>    actually, this platform driver uses a 4 lanes parallel bus, plus
>>>    a clock line, similar to a qspi. This to read an write registers
>>>    and as well to send samples at double data rate. Other DAC may
>>>    need "parallel" or "lvds" in the future.
>> If it is for register read + write as well, sounds to me like you need
>> to treat this as a new bus type, possibly then combined with a
>> backend, or something similar to spi offload?
>>
>> What bus does this currently sit on in your DT bindings?
>> (add an example)
> 
> 
> &amba {
> 
>     ref_clk: clk@44B00000 {
>         compatible = "adi,axi-clkgen-2.00.a";
>         reg = <0x44B00000 0x10000>;
>         #clock-cells = <0>;
>         clocks = <&clkc 15>, <&clkc 15>;
>         clock-names = "s_axi_aclk", "clkin1";
>         clock-output-names = "ref_clk";
>     };
> 
>     dac_tx_dma: dma-controller@0x44a30000 {
>         compatible = "adi,axi-dmac-1.00.a";
>         reg = <0x44a30000 0x10000>;
>         #dma-cells = <1>;
>         interrupt-parent = <&intc>;
>         interrupts = <0 57 IRQ_TYPE_LEVEL_HIGH>;
>         clocks = <&clkc 15>;
> 
>         adi,channels {
>             #size-cells = <0>;
>             #address-cells = <1>;
> 
>             dma-channel@0 {
>                 reg = <0>;
>                 adi,source-bus-width = <32>;
>                 adi,source-bus-type = <0>;
>                 adi,destination-bus-width = <32>;
>                 adi,destination-bus-type = <1>;
>             };
>         };
>     };
> 
>     backend: controller@44a70000 {
>         compatible = "adi,axi-dac-9.1.b";
>         reg = <0x44a70000 0x1000>;
>         dmas = <&dac_tx_dma 0>;
>         dma-names = "tx";
>         #io-backend-cells = <0>;
>         clocks = <&ref_clk>;
>         bus-type = <1>;  /* IIO QSPI */
>     };
> 
>     axi-ad3552r {
>         compatible = "adi,ad3552r";
>         reset-gpios = <&gpio0 92 GPIO_ACTIVE_LOW>;
>         io-backends = <&backend>;
>         #address-cells = <1>;
>         #size-cells = <0>;
>         channel@0 {
>             reg = <0>;
>             adi,output-range-microvolt = <(-10000000) (10000000)>;
>         };
>     };

Shouldn't the axi-ad3552r node be one level higher since it isn't
a memory-mapped device, but rather an external chip?

But based on the other feedback we got in this series and some
#devicetree IRC chat here is an alternate binding suggestion we
could consider.

First, even though the FPGA IP block for use with AD3225R uses
the same register map as the AXI DAC IP block, some of the
registers behave differently, so it makes sense to have a
different compatible string rather than using the bus-type
property to tell the difference between the two IP blocks.
There are likely more differences than just the bus type.

Second, technically, the AXI DAC IP block can't be used as
a generic SPI controller, so it wouldn't make sense to put
it in drivers/spi. But, from wiring point of view, it could
still make sense to use SPI DT bindings since we have SPI
wiring. At the same time, the AXI DAC IP block is also
providing extra functionality in addition to the SPI bus
so it makes sense to keep the io-backend bindings for those
extra bits.

    backend: spi@44a70000 {
        compatible = "adi,axi-dac-ad3225r";
        reg = <0x44a70000 0x1000>;
        dmas = <&dac_tx_dma 0>;
        dma-names = "tx";
        #io-backend-cells = <0>;
        clocks = <&ref_clk>;

        #address-cells = <1>;
        #size-cells = <0>;

        dac@0 {
            compatible = "adi,ad3552r";
            reg = <0>;

            /* 
             * Not sure how right this is - attempting to say that
             * the QSPI select pin is hardwired high, so the 4 SPI I/O
             * pins on the DAC are always functioning as SDIO0/1/2/3
             * as opposed to the usual 2 SDI/SDO pins and 2 unused.
             */
            spi-3-wire;
            spi-tx-bus-width = <4>;
            spi-rx-bus-width = <4>;

            reset-gpios = <&gpio0 92 GPIO_ACTIVE_LOW>;
            io-backends = <&backend>;

            #address-cells = <1>;
            #size-cells = <0>;

            channel@0 {
                reg = <0>;
                adi,output-range-microvolt = <(-10000000) (10000000)>;
            };
        };
    };



