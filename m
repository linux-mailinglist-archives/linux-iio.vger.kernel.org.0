Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E462C0559
	for <lists+linux-iio@lfdr.de>; Mon, 23 Nov 2020 13:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgKWMQ1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Nov 2020 07:16:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54147 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729372AbgKWMQ1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Nov 2020 07:16:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606133785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lXe5+vC9XhuqiWvB8SprIOltRTdJYIxBBDQ4j3P4YgE=;
        b=UQLDdW/FJXoFgrLwOnC06/TIiwbBSzZf8lhs6M0Tb4I2NYijq9kFF8z3X0VBhAmBmM0BIa
        U6KZmRtb0N1j/hKJlbK57MxAYqQmu3PIi3frDJ4DyHqbkBsA8krh5Nmbu/3Ple8awjwvd4
        rVkXBqKIc7agZkdv39FrndKlBbe/O+w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-bi6Ag2HcOCWgf6dXtmQ6Qg-1; Mon, 23 Nov 2020 07:16:23 -0500
X-MC-Unique: bi6Ag2HcOCWgf6dXtmQ6Qg-1
Received: by mail-ej1-f69.google.com with SMTP id y10so958999ejg.3
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2020 04:16:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lXe5+vC9XhuqiWvB8SprIOltRTdJYIxBBDQ4j3P4YgE=;
        b=L4GOa51oNPJIossQ3X1Xsl2PyrHBzSiDronKdWBl0nPrTEi3+RlvxpWZ/1GUp4GPWz
         w3iSMCwswHTLVGD0gqCgSQi6bzg5gCzw+WdV6fNVIUEv5cX3t0sqIfJwf4VH8REQXdeW
         XG7HaC6prNuP9Z271kcOje6vGPDq9lqYJntTM/lH/+Aq0d5bPyKsMo8DNKd821hLaqx7
         V/xeFarv7YUXJqrSGHO7Nf4zumwm3SERxm1CfBeqRMsmATkb3cr7LOU6Gfe/rHmw7cAe
         OMjYehImGFZ5g5kLzdu+Ld2PhHAZz8R74adsQFWKbLca6L8bMZBkLJz9yTHyoyr5Vm/B
         PcKQ==
X-Gm-Message-State: AOAM532pDHTTrhQ2vTFjP/JFqAnidWscgrhqbWF48FgUn8XG3gnHu/fP
        fZHeje+xL5yA/1eg0OdF/PLrTLbnVE5nF56XNoDcIx0YIwoDKgQPOcamMXHLGXdhEKSQPIFS5r/
        7FZoC/ErPhrVtZp26X84A
X-Received: by 2002:a05:6402:c83:: with SMTP id cm3mr46538999edb.189.1606133782032;
        Mon, 23 Nov 2020 04:16:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzlu7xwnh8BWC6vLqyoykLxoAYe2O5lhMVohFmamMLlf7fBHlEwPAtV6V2wyonz2GDFsiEWFQ==
X-Received: by 2002:a05:6402:c83:: with SMTP id cm3mr46538974edb.189.1606133781764;
        Mon, 23 Nov 2020 04:16:21 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id p14sm2383987edq.6.2020.11.23.04.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 04:16:21 -0800 (PST)
Subject: Re: [External] Using IIO to export laptop palm-sensor and lap-mode
 info to userspace?
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Pearson <markpearson@lenovo.com>,
        linux-iio@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Nitin Joshi1 <njoshi1@lenovo.com>, linux-input@vger.kernel.org
References: <9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com>
 <5a646527-7a1f-2fb9-7c09-8becdbff417b@lenovo.com>
 <20201007083602.00006b7e@Huawei.com>
 <218be284-4a37-e9f9-749d-c126ef1d098b@redhat.com>
 <20201112062348.GF1003057@dtor-ws>
 <3568c492-d9bd-c02d-4cbc-7f3eef605ef5@redhat.com>
 <20201113065832.GD356503@dtor-ws>
 <6df00683-9508-3dd9-831e-9b343658287b@redhat.com>
 <20201120095943.000001a6@Huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <aeb7bc51-0b27-198b-d3b5-50b18ad114e7@redhat.com>
Date:   Mon, 23 Nov 2020 13:16:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201120095943.000001a6@Huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 11/20/20 10:59 AM, Jonathan Cameron wrote:
> On Thu, 19 Nov 2020 16:39:07 +0100
> Hans de Goede <hdegoede@redhat.com> wrote:

>>>>>>>> On 2020-10-03 10:02 a.m., Hans de Goede wrote:  
>>>>>>>>> Hi All,
>>>>>>>>>
>>>>>>>>> Modern laptops can have various sensors which are kinda
>>>>>>>>> like proximity sensors, but not really (they are more
>>>>>>>>> specific in which part of the laptop the user is
>>>>>>>>> proximate to).
>>>>>>>>>
>>>>>>>>> Specifically modern Thinkpad's have 2 readings which we
>>>>>>>>> want to export to userspace, and I'm wondering if we
>>>>>>>>> could use the IIO framework for this since these readings
>>>>>>>>> are in essence sensor readings:
>>>>>>>>>
>>>>>>>>> 1. These laptops have a sensor in the palm-rests to
>>>>>>>>> check if a user is physically proximate to the device's
>>>>>>>>> palm-rests. This info will be used by userspace for WWAN
>>>>>>>>> functionality to control the transmission level safely.
>>>>>>>>>
>>>>>>>>> A patch adding a thinkpad_acpi specific sysfs API for this
>>>>>>>>> is currently pending:
>>>>>>>>> https://patchwork.kernel.org/patch/11722127/
>>>>>>>>>
>>>>>>>>> But I'm wondering if it would not be better to use
>>>>>>>>> IIO to export this info.  

<snip>

>>> On newer ARM we use "label" attribute in DTS:
>>>
>>> arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
>>>
>>>         ap_sar_sensor: proximity@28 {
>>>                 compatible = "semtech,sx9310";
>>>                 reg = <0x28>;
>>>                 #io-channel-cells = <1>;
>>>                 pinctrl-names = "default";
>>>                 pinctrl-0 = <&p_sensor_int_l>;
>>>
>>>                 interrupt-parent = <&tlmm>;
>>>                 interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
>>>
>>>                 vdd-supply = <&pp3300_a>;
>>>                 svdd-supply = <&pp1800_prox>;
>>>
>>>                 status = "disabled";
>>>                 label = "proximity-wifi";
>>>         };  
>>
>> Hmm, interesting. I did not know iio-devices could
>> have a label sysfs attribute (nor that that could be
>> set through device-tree). I was thinking about adding
>> an in_proximity_location sysfs attribute. But using
>> labels (and standardizing a set of label names) will
>> work nicely too.
> 
> It's fairly new.   Note we also have per channel labels
> though they are 'very new'.  Might be handy if the sensors
> appear as a single device despite being spread over the
> laptop.

Interesting, the thinkpad_acpi stuff currently has 2
proximity(ish) sensors:

1. Laptop is close to (on) someones lap
2. Someone's arms are resting on or close to the palmrest

Ideally we would indeed register 1 iio-dev with separate
channels for this, rather then having to register 2
(and the future maybe even more) iio-devs for this.

Can you give a pointer to docs / examples of using a
label per channel ?

>> Is there a know set of labels which ChromeOS is currently
>> using? If we are going to use labels for this it would
>> be good IMHO to define a set of standard labels for
>> this in say Documentation/ABI/testing/sysfs-bus-iio-labels.
> 
> If you do want to do this, please just put it under sysfs-bus-iio
> doc.  I want this to be in the top level doc.

Ok, ack.

Dmitry, can you perhaps dig up a full-list of labels
which ChromeOS is currently using to identify
proximity sensors for e.g. SAR related use?

Regards,

Hans

