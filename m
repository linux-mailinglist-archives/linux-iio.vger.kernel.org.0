Return-Path: <linux-iio+bounces-27525-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC7BCFE965
	for <lists+linux-iio@lfdr.de>; Wed, 07 Jan 2026 16:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACA5C3068361
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jan 2026 15:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20093396E9;
	Wed,  7 Jan 2026 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNhStM+5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B097E336EC7
	for <linux-iio@vger.kernel.org>; Wed,  7 Jan 2026 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767799267; cv=none; b=X/7FZhsxqjmfyJp/sTkVnX+QJwDSs1X69o3pLGisdj1VEI5pzXy9XmBBwAPJY8qTBzMQC+8TWvpwo4ryqV+ktRAdRQLI76I3cRTIF8zYLkugvc8ERzUuoxG2u3M482dupBmDKyi1b97TDqaCD9qMI5YW6+9hz2kPn0WwLnFtzzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767799267; c=relaxed/simple;
	bh=eXuXM2LfKvUBPj7bC+kcYrRbVy9Q6GzWBRQJOVYcmlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LwyfXPZ7wjd1H99qMpPllUqhSSuiAMGrpxQls9MLvIDoGRube7nKlnC+JNMd4Tb+Upw6VgvvxywDqo1qi0SaT0X/co0egnWXaunXoSkdCgPzLeFdvn6n6oQbNOJwNa0GAYPza2UfsL0YL5xJeWwzvOsymAfuPEdx6Ma+bPRNoOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNhStM+5; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4775ae77516so24227665e9.1
        for <linux-iio@vger.kernel.org>; Wed, 07 Jan 2026 07:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767799261; x=1768404061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hpUPZ5RhmCpDT+jo0BaREdmS2zyMNKBTJDPDa+mSTNU=;
        b=GNhStM+5OyFTPska6OfoPImQpoDNFLQu6JWlomHePHnnA3/G+uOvktvTYp7yaFuLe1
         D1XvU6GXkwD9DOtpXWS0Qms2D9X03gLEUKcZz650EWGG8mm9ys18lL/pbJOoRGKroSQ5
         mOI+Ln1LYELTbvXFaFtilqHI8gFVrUhDvp0zHNliG6RtwwYvIGzyxzoN0oJ24QtkJAjC
         T8pRTFf00/W3enoAq7JYSzQtIjDEshT/UXd6wAn9dEY73BNzRl7ApumHPQ2RhSfXvLwk
         6bLBdPM2IxmX+eGujhW8CXxbMH73+B3E1g773tcWxtH01g82gds1abakw0PhTwdiBFM8
         nabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767799261; x=1768404061;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hpUPZ5RhmCpDT+jo0BaREdmS2zyMNKBTJDPDa+mSTNU=;
        b=WQnPnekfqplxSTY07jd4AsOGyk6MMJyfT0OgmfOUYenCTSVkGedU1EhPmpsS0n9idD
         UBZ4WwyuP4ePGE+bhz563QhwgkAAAGmHbnldVnPa4v4HAHlKfOCM8Nmn8cbSslxFlkIQ
         QQ1En8Rez5sznf3ZCdhQo5ht5K1miM2haTiTzpzQ3FU1ewjzPrKDJCEExI5nKu01q079
         BifqpFJd9Ruu1g2VcPZBCcLfTYZ6/WSmRbJHcsP4UlxS0Epz5ZpmtQwrVElSor+3ERZ3
         yRDRtw4QEcFjGcfwfWwynVaCvWYelpJuhVtFZ4MOtCmn9/jBSlX2USzXHsJYn0/rltQ7
         uE1g==
X-Forwarded-Encrypted: i=1; AJvYcCUC499YqP1UPkWDTlFqnxd0Pf1K0/R9CZnv4v6AlXG3OkBO+BUtxwGmFr7iA6LEPViAhD9eP009U0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZwWgNwTVjuG1ii5zZpT/UJk3QPUIKVg5xbeMS+mQFMifDZMG5
	Fzf12pcMLr7OqIrVf/nXt2b9J21AKIVhZxukmZIAuAaTzRcBFnWtowOF
X-Gm-Gg: AY/fxX6PWqT1TyULn+C+abHftL/LlY+rZfDPmHYIht/IebXVdbZNG4W5Uj0D/qwIYrZ
	E+/JEY7ek2PSX4X7TMXLJ/DZyqW9QQuLe8BY68k8+IJrLw/Cl6vTUcytcBbSpNvD14hP+wEvl7S
	CQmy5v8Zo7V1w755gCOOzuLv97r6V8sWPrtFoN2ylbRiRzQ86S223/MDGNYWIRlKK83dRqVdxhD
	L8VBYCqfk5hGed1Wd3mPJooseqRcjKfN5b602BavWYH2d5lXcxw9OAdobiAJ8sUme2N7rciY+jL
	veNAV9XVrx4z96RKtWfUVS20ASk9Njbx3Gmjcq75CcCEAfkQHKM7+Jkn0odBolbLIVKvW8pxzi7
	vRgsnlVXw3wWbE+zSdOUUH4QsncaHKpPl9DxkOFEU9qepsd433oREU0twnIcH08gduV8FUgSN43
	FkCct0/OAadyozg6w=
X-Google-Smtp-Source: AGHT+IFN3tHCepgfCw11GoExlGSkTzE8/w3l0cvAFbX3GwK84QP3RK+c6Ndkf0qCwv1hl4a7XEeZvA==
X-Received: by 2002:a05:600c:46c4:b0:47d:403e:4eaf with SMTP id 5b1f17b1804b1-47d84b18ef7mr37281035e9.10.1767799260961;
        Wed, 07 Jan 2026 07:21:00 -0800 (PST)
Received: from [172.24.138.145] ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8636e588sm17062955e9.0.2026.01.07.07.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 07:21:00 -0800 (PST)
Message-ID: <05379c1e-9114-494e-b7c7-c95243049197@gmail.com>
Date: Wed, 7 Jan 2026 16:20:56 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] docs: iio: Add documentation for MAX22007 driver
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 jan.sun97@gmail.com, gastmaier@gmail.com
References: <20251219-max22007-dev-v1-0-242da2c2b868@analog.com>
 <20251219-max22007-dev-v1-2-242da2c2b868@analog.com>
 <20251219164751.000071a1@huawei.com>
Content-Language: en-US
From: Janani Sunil <jan.sun97@gmail.com>
In-Reply-To: <20251219164751.000071a1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Johnathan,

Thank you for getting back to me.

On 12/19/25 17:47, Jonathan Cameron wrote:
> On Fri, 19 Dec 2025 16:31:16 +0100
> Janani Sunil <janani.sunil@analog.com> wrote:
>
>> Add documentation for MAX22007 driver which describes how the user
>> can access the driver using dtoverlays
>>
>> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> Hi Janani,
>
> We've recently had a few comments on whether driver specific docs add value
> (for particular drivers, sometimes they definitely do!).  From what I'm
> seeing here, I'm not thinking this one needs a document.  Not most drivers
> don't have such a file because they make use of standard ABI that is well
> documented.  DT stuff always belongs in the dt-binding rather than these
> files.  With both those elements gone there isn't much value to this file.
> So I'd drop it.  We can easily add a file if something complex shows up
> in later patches, that justifies this.
>
> Thanks,
>
> Jonathan


I agree that this driver does not need a specific document. Will drop it.

>
>> ---
>>   Documentation/iio/index.rst    |   1 +
>>   Documentation/iio/max22007.rst | 145 +++++++++++++++++++++++++++++++++++++++++
>>   MAINTAINERS                    |   1 +
>>   3 files changed, 147 insertions(+)
>>
>> diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
>> index 315ae37d6fd4..7601bc2882e7 100644
>> --- a/Documentation/iio/index.rst
>> +++ b/Documentation/iio/index.rst
>> @@ -37,4 +37,5 @@ Industrial I/O Kernel Drivers
>>      adxl345
>>      bno055
>>      ep93xx_adc
>> +   max22007
>>      opt4060
>> diff --git a/Documentation/iio/max22007.rst b/Documentation/iio/max22007.rst
>> new file mode 100644
>> index 000000000000..e04c563f1fd0
>> --- /dev/null
>> +++ b/Documentation/iio/max22007.rst
>> @@ -0,0 +1,145 @@
>> +.. SPDX-License-Identifier: GPL-2.0-only
>> +
>> +===============
>> +MAX22007 driver
>> +===============
>> +
>> +Device driver for Analog Devices Inc. MAX22007 quad-channel industrial DAC.
>> +The module name is ``max22007``.
>> +
>> +Supported devices
>> +=================
>> +
>> +* `MAX22007 <https://www.analog.com/en/products/max22007.html>`_
>> +
>> +Wiring connections
>> +==================
>> +
>> +The MAX22007 uses a standard SPI interface.
> I'd not bother with this section.  Most SPI devices after all use
> the standard interface, so we can document this by not documenting anything
> else :)
>
>> +
>> +Device Tree Configuration
>> +=========================
> Anything here should be in the dt-binding. As such this section isn't useful.
>
>> +
>> +The device supports both global and per-channel configuration through device tree.
>> +
>> +Global Properties:
>> +
>> +* ``reset-gpios``: GPIO pin for hardware reset (optional, falls back to
>> +  software reset if not specified)
>> +* ``vdd-supply``: Low-Voltage Power Supply from +2.7V to +5.5V (optional)
>> +* ``hvdd-supply``: Positive High-Voltage Power Supply from +8V to (HVSS +24V)
>> +  for the Output Channels (optional)
>> +* ``hvss-supply``: Negative High-Voltage Power Supply from -2V to 0V for the
>> +  Output Channels (optional)
>> +
>> +Per-channel properties:
>> +
>> +* ``adi,type``: Specify the channel output type - must be either "voltage" or "current" (mandatory)
>> +
>> +Note: The driver operates in transparent mode (immediate register-to-output updates).
>> +Channel mode is determined by the ``adi,type`` property:
>> +
>> +* ``adi,type = "current"``: the channel operates in current mode
>> +* ``adi,type = "voltage"``: the channel operates in voltage mode
>> +
>> +Device attributes
>> +=================
>> +
>> +The MAX22007 driver provides IIO DAC interfaces that vary based on the
>> +configured channel mode. Each channel appears as a separate IIO device
>> +attribute:
>> +
>> +* ``out_voltage_raw`` (voltage mode channels)
>> +* ``out_current_raw`` (current mode channels)
>> +* ``out_voltage_scale`` / ``out_current_scale`` (channel scaling factors)
>> +* ``out_voltage_powerdown`` / ``out_current_powerdown`` (channel power control)
>> +
>> +The driver automatically configures the IIO channel type based on the configured
>> +channel mode from device tree.
> This bit feels very standard and so not in need of extra documentation.
>
>> +
>> +Power Mode Control
>> +==================
>> +
>> +Each channel provides standard IIO ``powerdown`` attributes for runtime power
>> +control:
>> +
>> +* Write ``1`` to power down (disable) the channel output
>> +* Write ``0`` to power up (enable) the channel output
>> +* Read the attribute to get the current power state (1=powered down, 0=powered up)
>> +
>> +This allows individual channels to be powered on/off independently for power
>> +management and safety purposes.
> Likewise, this is very standard.
>
>> +
>> +Usage Examples
>> +==============
>> +
>> +Setting DAC output values:
>> +
>> +.. code-block:: bash
>> +
>> +   # Set channel 0 (voltage mode) to raw value 655 (≈2V)
>> +   # Output is updated immediately in transparent mode
>> +   echo 655 > /sys/bus/iio/devices/iio:deviceX/out_voltage0_raw
>> +
>> +   # Set channel 1 (current mode)
>> +   # Output is updated immediately in transparent mode
>> +   echo 1024 > /sys/bus/iio/devices/iio:deviceX/out_current1_raw
>> +
>> +Controlling channel power modes:
>> +
>> +.. code-block:: bash
>> +
>> +   # Enable channel 0 (power up)
>> +   echo 0 > /sys/bus/iio/devices/iio:deviceX/out_voltage0_powerdown
>> +
>> +   # Disable channel 1 (power down)
>> +   echo 1 > /sys/bus/iio/devices/iio:deviceX/out_current1_powerdown
>> +
>> +   # Check current power state (0=powered up, 1=powered down)
>> +   cat /sys/bus/iio/devices/iio:deviceX/out_voltage0_powerdown
>> +
>> +Reading channel values and scale factors:
>> +
>> +.. code-block:: bash
>> +
>> +   # Read raw DAC value
>> +   cat /sys/bus/iio/devices/iio:deviceX/out_voltage0_raw
>> +
>> +   # Read scale factor (volts per LSB)
>> +   cat /sys/bus/iio/devices/iio:deviceX/out_voltage0_scale
>> +
>> +Check available channels:
>> +
>> +.. code-block:: bash
>> +
>> +   ls /sys/bus/iio/devices/iio:deviceX/out_*_raw
>> +
>> +Scale Calculations
>> +==================
>> +
>> +The driver provides accurate scale factors based on the hardware configuration:
> This information doesn't need to be provided explicitly.  Anyone who
> wonders in detail about it can check the driver. For most users the fact
> it obeys the standard ABI rules is eough.
>
>> +
>> +**Voltage Mode:**
>> +
>> +- Scale = (5 × 2.5V) / 4096 = 0.003051757 V per LSB
>> +- Range: 0V to 12.5V over 12-bit (0-4095)
>> +- Formula: Output = Raw_Value × Scale
>> +
>> +**Current Mode:**
>> +
>> +- Scale = (2.5V / (2 × 50Ω)) / 4096 = 0.000006103515625 A per LSB
>> +- Range: 0A to 0.025A over 12-bit (0-4095)
>> +- Formula: Output = Raw_Value × Scale
>> +
>> +Driver Architecture
>> +===================
>> +
>> +The driver implements:
>> +
>> +* **CRC8 Error Checking**: Always-enabled CRC8 for SPI data integrity
>> +* **Channel Configuration**: Supports per-channel mode and power configuration
>> +
>> +Channel configuration (voltage/current mode) is set via the ``adi,type``
>> +device tree property and cannot be changed dynamically The driver requires
>> +proper device tree configuration with mandatory ``adi,type`` property for each
>> +channel.
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e1addbd21562..6561455732c9 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1599,6 +1599,7 @@ L:	linux-iio@vger.kernel.org
>>   S:	Supported
>>   W:	https://ez.analog.com/linux-software-drivers
>>   F:	Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
>> +F:	Documentation/iio/max22007.rst
>>   
>>   ANALOG DEVICES INC ADA4250 DRIVER
>>   M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
>>

