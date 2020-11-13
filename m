Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1452B1616
	for <lists+linux-iio@lfdr.de>; Fri, 13 Nov 2020 07:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgKMG6i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Nov 2020 01:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgKMG6h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Nov 2020 01:58:37 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF857C0613D1;
        Thu, 12 Nov 2020 22:58:37 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 62so6327260pgg.12;
        Thu, 12 Nov 2020 22:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OebbN6nzg+GWM/erGm0lG5ieqspWbMcIg1x8k8UCh/0=;
        b=OLdX2k6XfYZD4DkvtNGDOJhPjqyB4UblDyauonw9HzJAuQlD771oRGGjCrTfry2DgP
         E+yMcVf1Pa2f98taezQoKyqA4uSnQe3PM/4/VY9PenrxlmS33Bg3BZokeJ1ACNkwcHIc
         cwx8hk+Fxoe75JkmyGDHcZkL/WuvuieOagm04jHVMOP0joPHhcy9WFOGOIpBxSZ7P3b0
         vqMY82cpsRG7idPwLD+WFQTK67VgDNKDx1MkTuR22nAf3nHTFHe5SKMAoaDnYlE8XmL/
         D1oJsEKk2c129CuFvRjaRm2AiQagAN5/VjtES1xjIvWUq/U2Y/CdF1R84mjSaSv8OHTY
         jqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OebbN6nzg+GWM/erGm0lG5ieqspWbMcIg1x8k8UCh/0=;
        b=lVkP4e+RvCOVPvZJtux5bg9UvYvV4Y5F85pUhLihbpdqxlOLytXGjbWztBSWAgIv+G
         vnw49kyPF+xiyl6PsY/12K6uCXY8QwthUSxHa5BMOLGDOklNbnpMBY3GPzsxitUj8FLN
         103mYczcL93VkwAp3O3kMAx7vK2QnNXxy+HRgQiblP9xWa4cznYP9TX23q8DamXrmaHF
         tyNDGIwxmL0+8cLkQnlOhGa8Zs60ls8bumOK5ZX+E7671zbb5dlgLx5JgI6kxs3DoDov
         xkXZn+RBjcQbDz9DLNGSxEkVepJTq4XjeAkEqJNNK0xMzCjgx8cO0wNUEvUXYgT2aU4F
         xz+w==
X-Gm-Message-State: AOAM531h50JtNeONjB7kqnwDNW7eLE59bdClYZ5iVx86ifuGhfRDpDqg
        G1zYVL7mumZ/iudcdNmxziE=
X-Google-Smtp-Source: ABdhPJwYjHRpyaIZDE4C6vn8XCX4Aig9/wfieMdDLF+QuqXMiDpK41waqeBN3t8prQ/Wg6gz0zUImA==
X-Received: by 2002:a17:90a:8805:: with SMTP id s5mr1252667pjn.116.1605250717166;
        Thu, 12 Nov 2020 22:58:37 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id g15sm7838329pgi.89.2020.11.12.22.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 22:58:34 -0800 (PST)
Date:   Thu, 12 Nov 2020 22:58:32 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Pearson <markpearson@lenovo.com>,
        linux-iio@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Nitin Joshi1 <njoshi1@lenovo.com>, linux-input@vger.kernel.org
Subject: Re: [External] Using IIO to export laptop palm-sensor and lap-mode
 info to userspace?
Message-ID: <20201113065832.GD356503@dtor-ws>
References: <9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com>
 <5a646527-7a1f-2fb9-7c09-8becdbff417b@lenovo.com>
 <20201007083602.00006b7e@Huawei.com>
 <218be284-4a37-e9f9-749d-c126ef1d098b@redhat.com>
 <20201112062348.GF1003057@dtor-ws>
 <3568c492-d9bd-c02d-4cbc-7f3eef605ef5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3568c492-d9bd-c02d-4cbc-7f3eef605ef5@redhat.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Nov 12, 2020 at 10:50:12AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 11/12/20 7:23 AM, Dmitry Torokhov wrote:
> > On Wed, Oct 07, 2020 at 11:51:05AM +0200, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 10/7/20 10:36 AM, Jonathan Cameron wrote:
> >>> On Mon, 5 Oct 2020 22:04:27 -0400
> >>> Mark Pearson <markpearson@lenovo.com> wrote:
> >>>
> >>>> Adding Nitin, lead for this feature, to the thread
> >>>
> >>> +CC linux-input and Dmitry for reasons that will become clear below.
> >>>>
> >>>> On 2020-10-03 10:02 a.m., Hans de Goede wrote:
> >>>>> Hi All,
> >>>>>
> >>>>> Modern laptops can have various sensors which are kinda
> >>>>> like proximity sensors, but not really (they are more
> >>>>> specific in which part of the laptop the user is
> >>>>> proximate to).
> >>>>>
> >>>>> Specifically modern Thinkpad's have 2 readings which we
> >>>>> want to export to userspace, and I'm wondering if we
> >>>>> could use the IIO framework for this since these readings
> >>>>> are in essence sensor readings:
> >>>>>
> >>>>> 1. These laptops have a sensor in the palm-rests to
> >>>>> check if a user is physically proximate to the device's
> >>>>> palm-rests. This info will be used by userspace for WWAN
> >>>>> functionality to control the transmission level safely.
> >>>>>
> >>>>> A patch adding a thinkpad_acpi specific sysfs API for this
> >>>>> is currently pending:
> >>>>> https://patchwork.kernel.org/patch/11722127/
> >>>>>
> >>>>> But I'm wondering if it would not be better to use
> >>>>> IIO to export this info.
> >>>
> >>> My first thought on this is it sounds more like a key than a sensor
> >>> (simple proximity sensors fall into this category as well.)
> > 
> > [ sorry for sitting on this thread for so long ]
> > 
> > So I think the important question here is if we only ever want yes/no
> > answer, or if we can consider adjusting behavior of the system based on
> > the "closeness" of an object to the device, in which case I think IIO is
> > more flexible.
> > 
> > FWIW in Chrome OS land we name IIO proximity sensors using a scheme
> > "proximity-lte", "proximity-wifi", "proximity-wifi-left",
> > "proximity-wifi-right", etc, and then userspace implements various
> > policies (SAR, etc) based off it.
> 
> Interesting, so 2 questions:
> 
> 1. So your encoding the location in the sensor's parent-device name
> instead of using a new sysfs attribute for this ?

I think it depends on the kernel we use and architecture. On x86 I think
we rely on udev, like this:

https://chromium.googlesource.com/chromiumos/overlays/board-overlays/+/master/overlay-nocturne/chromeos-base/chromeos-bsp-nocturne/files/udev/99-cros-sx-proximity.rules

DEVPATH=="*/pci0000:00/0000:00:15.1/*", SYMLINK+="proximity-wifi-right"
DEVPATH=="*/pci0000:00/0000:00:19.1/*", SYMLINK+="proximity-wifi-left"
ATTR{events/in_proximity1_USE_CS1_thresh_either_en}="1"

On newer ARM we use "label" attribute in DTS:

arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi

        ap_sar_sensor: proximity@28 {
                compatible = "semtech,sx9310";
                reg = <0x28>;
                #io-channel-cells = <1>;
                pinctrl-names = "default";
                pinctrl-0 = <&p_sensor_int_l>;

                interrupt-parent = <&tlmm>;
                interrupts = <24 IRQ_TYPE_LEVEL_LOW>;

                vdd-supply = <&pp3300_a>;
                svdd-supply = <&pp1800_prox>;

                status = "disabled";
                label = "proximity-wifi";
        };

> 
> 2. Do these sensors just give a boolean value atm, or do they already
> report a range ?  IIRC one of the objections from the iio folks in
> the Lenovo case was that booleans are not really a good fit for iio
> (IIRC they also said we could still use iio for this).

One of the sensors we use is sx9310 that I believe can report range, but
I think we configure them to trigger when a threshold is crossed.

Events are handled by our powerd:

https://chromium.googlesource.com/chromiumos/platform2/+/master/power_manager/powerd/system/sar_watcher.cc

> 
> Perhaps you can provide an URL to the kernel code implementing these ?

drivers/iio/proximity/sx9310.c

Also sx932x - https://lore.kernel.org/patchwork/patch/1005708/

Thanks.

-- 
Dmitry
