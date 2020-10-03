Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F60228246A
	for <lists+linux-iio@lfdr.de>; Sat,  3 Oct 2020 16:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbgJCOCo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Oct 2020 10:02:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29368 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725781AbgJCOCo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Oct 2020 10:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601733763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1smS26iDEmjvEZDCadYVdJBNsLVw0wkaqHbqDYTnwZU=;
        b=LqyGM0LQgyvTK5OEoPu5Qe8aCYD51LEu4auGJxsdp8xhO+FMfTF/GCNnlla2o5IWm5xKVx
        imK6F2DclQGNqtN2mdTj8QSC/iTsYBxB3lCmDjte/UoMkPOOpkVMZNMHN/7mhjbikU/uXA
        NSmt3X6fBCi8LbNzDuMcLMsPDzfqipA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-aw-sZJqcPUGmzhMcceblNQ-1; Sat, 03 Oct 2020 10:02:40 -0400
X-MC-Unique: aw-sZJqcPUGmzhMcceblNQ-1
Received: by mail-ed1-f69.google.com with SMTP id x23so2303719eds.5
        for <linux-iio@vger.kernel.org>; Sat, 03 Oct 2020 07:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=1smS26iDEmjvEZDCadYVdJBNsLVw0wkaqHbqDYTnwZU=;
        b=P6vYCnA+Evk1gd7Viue60kTXvMC+Of4wvPiruiEFdSiw3S7WfbTYi7oBJjIQGuGS1b
         iO7AAM1R4xGhPw9dxV9FtcdmPBozoDZ3MoGXLsHL54MeXbdUoDFK7RtWqt/TVhcXKX28
         bKVI6lYgfMLd1wwGaZeT+Zkhsg3cYlj8cvDJTQ5bBpQJJCIDvMpN6FIFUIRl3txpX+Kt
         VxqFFoiL8JQHJgqzyZPNpVShbrQJArxr9Ik5tfErubGDlniGssJJE2qJMzUyoe4ErYs1
         EMH81Js9bwWehlV/XXqSC45xmHaQlWeJBa3XKaWRGHQUgXnoYmY/MwjqbfI4sfQuj64e
         ZthA==
X-Gm-Message-State: AOAM531ky23vTw7zevcUxSG7UJ7AWJJkrKK/2gbQpngbZ+A3a+UBH/Ud
        leZmVVE2njX2hd57siZJjQQxY84eXxehSc0LsXHkItO39sm69JYVnionP4l2ghhChvui4ofphej
        FApN4H6uIqrW3gNrFQNUu
X-Received: by 2002:a17:906:2655:: with SMTP id i21mr6429585ejc.511.1601733759474;
        Sat, 03 Oct 2020 07:02:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyavrP03mMDs0YFxS8nXY5NAZHfRsa8Zjd0jhowEUts1Nvf6oWbCHSCmDNQAzQVK88xxQdt1w==
X-Received: by 2002:a17:906:2655:: with SMTP id i21mr6429565ejc.511.1601733759229;
        Sat, 03 Oct 2020 07:02:39 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id q14sm2646223ejo.53.2020.10.03.07.02.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2020 07:02:38 -0700 (PDT)
To:     linux-iio@vger.kernel.org
Cc:     Mark Pearson <markpearson@lenovo.com>,
        Bastien Nocera <hadess@hadess.net>
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Using IIO to export laptop palm-sensor and lap-mode info to
 userspace?
Message-ID: <9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com>
Date:   Sat, 3 Oct 2020 16:02:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All,

Modern laptops can have various sensors which are kinda
like proximity sensors, but not really (they are more
specific in which part of the laptop the user is
proximate to).

Specifically modern Thinkpad's have 2 readings which we
want to export to userspace, and I'm wondering if we
could use the IIO framework for this since these readings
are in essence sensor readings:

1. These laptops have a sensor in the palm-rests to
check if a user is physically proximate to the device's
palm-rests. This info will be used by userspace for WWAN
functionality to control the transmission level safely.

A patch adding a thinkpad_acpi specific sysfs API for this
is currently pending:
https://patchwork.kernel.org/patch/11722127/

But I'm wondering if it would not be better to use
IIO to export this info.

2. These laptops have something called lap-mode, which
determines if the laptop's firmware thinks that it is on
a users lap, or sitting on a table. This influences the
max. allowed skin-temperature of the bottom of the laptop
and thus influences thermal management.  Like the palm-rest
snesors, this reading will likely also be used for
controlling wireless transmission levels in the future.

Note that AFAIK the lap_mode reading is not a single sensor
reading, it is a value derived from a bunch of sensor readings,
the raw values of which may or may not be available
separately.

So looking at existing IIO userspace API docs, focussing on
proximity sensors I see:

Documentation/ABI/testing/sysfs-bus-iio
Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935

Where the latter seems to not really be relevant.

 From the generic IO API doc, this bit is the most
interesting:

What:           /sys/.../iio:deviceX/in_proximity_raw
What:           /sys/.../iio:deviceX/in_proximity_input
What:           /sys/.../iio:deviceX/in_proximityY_raw
KernelVersion:  3.4
Contact:        linux-iio@vger.kernel.org
Description:
                 Proximity measurement indicating that some
                 object is near the sensor, usually by observing
                 reflectivity of infrared or ultrasound emitted.
                 Often these sensors are unit less and as such conversion
                 to SI units is not possible. Higher proximity measurements
                 indicate closer objects, and vice versa. Units after
                 application of scale and offset are meters.

This seems to be a reasonable match for the Thinkpad sensors
we are discussing here, although those report a simple
0/1 value.

What is missing for the ThinkPad case is something like this:

What:		/sys/.../iio:deviceX/proximity_sensor_location
KernelVersion:  5.11
Contact:        linux-iio@vger.kernel.org
Description:
		Specifies the location of the proximity sensor /
		specifies proximity to what the sensor is measuring.
		Reading this file returns a string describing this, valid values
		for this string are: "screen", "lap", "palmrest"
		Note the list of valid values may be extended in the
		future.

So what do you (IIO devs) think about this?

Would adding a proximity_sensor_location attribute be a reasonable
thing to do for this; and do you think that this would be a good idea ?

Regards,

Hans

