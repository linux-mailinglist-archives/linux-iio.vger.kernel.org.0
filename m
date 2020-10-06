Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E73D2843EC
	for <lists+linux-iio@lfdr.de>; Tue,  6 Oct 2020 04:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgJFCEd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Oct 2020 22:04:33 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.116]:12801 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725901AbgJFCEd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Oct 2020 22:04:33 -0400
Received: from [100.112.4.31] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-c.us-east-1.aws.symcld.net id ED/19-08329-FA0DB7F5; Tue, 06 Oct 2020 02:04:31 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRWlGSWpSXmKPExsWS8eIhr+76C9X
  xBssPMVl8/Xab3eLN8elMFvOOvGNxYPb4tW0Ni8f7fVfZPD5vkgtgjmLNzEvKr0hgzZhy+RBz
  wVzZinvzXrE3MB6U6GLk4hAS+M8ocevjOUYI5zmjxJHbv9i7GDk4hAXiJZY80epi5OQQEXCRO
  L78PCOIzSzgKbHm6VcwW0jAVuLZsw0sIDabgLbEli2/2EBaeYHidxYrgIRZBFQkdi2YCFYiKh
  Ahseb4RCYQm1dAUOLkzCdgcU4BO4m9U5ayQIy3kJg5H2aVuMStJ/OZIGx5ieats5lBbAkBBYl
  Z7TvZIewEiWUv7zBPYBSchWTsLCSjZiEZNQvJqAWMLKsYTZOKMtMzSnITM3N0DQ0MdA0NjXRN
  dY0N9RKrdJP1Sot1UxOLS3SB3PJiveLK3OScFL281JJNjMBoSClgld/B+Ov1B71DjJIcTEqiv
  CxnquOF+JLyUyozEosz4otKc1KLDzHKcHAoSfAmnAPKCRalpqdWpGXmACMTJi3BwaMkwjvpPF
  Cat7ggMbc4Mx0idYpRUUqc1xkkIQCSyCjNg2uDJYNLjLJSwryMDAwMQjwFqUW5mSWo8q8YxTk
  YlYR5C0Gm8GTmlcBNfwW0mAlo8e2jFSCLSxIRUlINTCsy+k24wn8+3By+61bVqYkL8uVPez6s
  Zbd+ssl0ZVdjfebHr86Xevca7Gzm+aqaYGcltm5TqLO5Q+/pjco2dpvkP+9PvvHS0Gpf1uw9l
  4/f+P3NLzVn//4VMo9uCSlcf73/9pkdggzuQZqNvyYHx6ceXXrWw8561Zp234wTwv9nc3Jeec
  mluIQlU6tBzE1GfZHOxOCvt7l+Wh031O6Xsf2RMcstNcmrMi/hj8Mt4YsTVzBvkP0b2d0RvDp
  PJJDxjDx7UqiMTmdEwenmm9PtdL+2SXr/j7NSPNJxe+EVTrFPEd/2FRzecmtyOrNwQnNdpU1v
  7r4em90cMpOXNyrd03l19N276fcYIv1+LCs8p8RSnJFoqMVcVJwIAHFKSYqBAwAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-42.tower-416.messagelabs.com!1601949870!1105553!1
X-Originating-IP: [104.232.225.13]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28515 invoked from network); 6 Oct 2020 02:04:31 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.13)
  by server-42.tower-416.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 6 Oct 2020 02:04:31 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id C823611DAC5E8BE67192;
        Mon,  5 Oct 2020 22:04:30 -0400 (EDT)
Received: from localhost.localdomain (10.46.54.144) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Mon, 5 Oct 2020
 19:04:29 -0700
Subject: Re: [External] Using IIO to export laptop palm-sensor and lap-mode
 info to userspace?
To:     Hans de Goede <hdegoede@redhat.com>, <linux-iio@vger.kernel.org>
CC:     Bastien Nocera <hadess@hadess.net>,
        Nitin Joshi1 <njoshi1@lenovo.com>
References: <9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <5a646527-7a1f-2fb9-7c09-8becdbff417b@lenovo.com>
Date:   Mon, 5 Oct 2020 22:04:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.46.54.144]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Adding Nitin, lead for this feature, to the thread

On 2020-10-03 10:02 a.m., Hans de Goede wrote:
> Hi All,
> 
> Modern laptops can have various sensors which are kinda
> like proximity sensors, but not really (they are more
> specific in which part of the laptop the user is
> proximate to).
> 
> Specifically modern Thinkpad's have 2 readings which we
> want to export to userspace, and I'm wondering if we
> could use the IIO framework for this since these readings
> are in essence sensor readings:
> 
> 1. These laptops have a sensor in the palm-rests to
> check if a user is physically proximate to the device's
> palm-rests. This info will be used by userspace for WWAN
> functionality to control the transmission level safely.
> 
> A patch adding a thinkpad_acpi specific sysfs API for this
> is currently pending:
> https://patchwork.kernel.org/patch/11722127/
> 
> But I'm wondering if it would not be better to use
> IIO to export this info.
> 
> 2. These laptops have something called lap-mode, which
> determines if the laptop's firmware thinks that it is on
> a users lap, or sitting on a table. This influences the
> max. allowed skin-temperature of the bottom of the laptop
> and thus influences thermal management.  Like the palm-rest
> snesors, this reading will likely also be used for
> controlling wireless transmission levels in the future.
> 
> Note that AFAIK the lap_mode reading is not a single sensor
> reading, it is a value derived from a bunch of sensor readings,
> the raw values of which may or may not be available
> separately.
> 
> So looking at existing IIO userspace API docs, focussing on
> proximity sensors I see:
> 
> Documentation/ABI/testing/sysfs-bus-iio
> Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935
> 
> Where the latter seems to not really be relevant.
> 
>  From the generic IO API doc, this bit is the most
> interesting:
> 
> What:           /sys/.../iio:deviceX/in_proximity_raw
> What:           /sys/.../iio:deviceX/in_proximity_input
> What:           /sys/.../iio:deviceX/in_proximityY_raw
> KernelVersion:  3.4
> Contact:        linux-iio@vger.kernel.org
> Description:
>                  Proximity measurement indicating that some
>                  object is near the sensor, usually by observing
>                  reflectivity of infrared or ultrasound emitted.
>                  Often these sensors are unit less and as such conversion
>                  to SI units is not possible. Higher proximity measurements
>                  indicate closer objects, and vice versa. Units after
>                  application of scale and offset are meters.
> 
> This seems to be a reasonable match for the Thinkpad sensors
> we are discussing here, although those report a simple
> 0/1 value.
> 
> What is missing for the ThinkPad case is something like this:
> 
> What:        /sys/.../iio:deviceX/proximity_sensor_location
> KernelVersion:  5.11
> Contact:        linux-iio@vger.kernel.org
> Description:
>          Specifies the location of the proximity sensor /
>          specifies proximity to what the sensor is measuring.
>          Reading this file returns a string describing this, valid values
>          for this string are: "screen", "lap", "palmrest"
>          Note the list of valid values may be extended in the
>          future.
> 
> So what do you (IIO devs) think about this?
> 
> Would adding a proximity_sensor_location attribute be a reasonable
> thing to do for this; and do you think that this would be a good idea ?
> 
> Regards,
> 
> Hans
> 
