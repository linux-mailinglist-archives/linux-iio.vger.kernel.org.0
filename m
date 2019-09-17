Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F996B4D25
	for <lists+linux-iio@lfdr.de>; Tue, 17 Sep 2019 13:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfIQLqg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Sep 2019 07:46:36 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:37443 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfIQLqg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Sep 2019 07:46:36 -0400
Received: by mail-pf1-f172.google.com with SMTP id y5so2019686pfo.4
        for <linux-iio@vger.kernel.org>; Tue, 17 Sep 2019 04:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vn7f2BvOOWhrCWhje8l+tWrmUWknHTs1DJbtD47MmVg=;
        b=F8zP3vW+au483SgGQAot1p1wCDJJaI1wZjCDJc7sBhwi+3JeZaygXhryQPVGOizAhT
         cDvkdGYb6g4QCY5YfuvOe/FDoNw0RESswz9XSJ9bJwU26wwuwMVIANIcavpzs7bHRsUr
         VbjCzjMbVI6gD5pde2HO5jpj/HoIKOGvFouyMbygSDpQSBeVDeCAN/M27UPhOPh5a9ed
         RNZN31ChdE0b9cgYcszfCZLgqxqUFCU8TjkHrl+G4IkpL5tz8GE+m+1oQ63e9emr6K7E
         EWdAHNrr+//1gBVSRcZj7Djo173XOYhEG4uI7F0chB4++Oo7WcUNo93/ywr7fqNTfScO
         nVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vn7f2BvOOWhrCWhje8l+tWrmUWknHTs1DJbtD47MmVg=;
        b=XdCesDtuKLlUkoSf50cc5GXA2/YQjnxRNuOKrLMkZ2T8rr9RgHd4JGS3lqdhE/HKAY
         LOpIPHMF1LhuSoZuFJQZWVuFCc2tg+oLaGqaYjjyTrp/QGqnaOhliY/nqFnOMtTGVf5u
         E8tPGYnHo4vhzrtZQLThia5+yTCT9CQFOsJ0u9QcwF7kRA/FbiynJomacT1O8qdN+dHp
         NV68663suuZEYeXBs+cZShyvsCeVbo2N/9VQGm6MyQBke/o1mOGXBAppwbztTbDeJ0BX
         1UxbZyYa2lVDfZ6h6uozC978VheBa9q3ls3wMS6Gc4t+syjG9jqXLi1XgMY/smAbZWFm
         yozQ==
X-Gm-Message-State: APjAAAUUBbPROPloOhyoEUHa7SylVnNlCq2ZqdgBnk9Xf6ozMDJFnWBb
        +mveNvSV6Dvi5L7sjsMM91+5u/oE
X-Google-Smtp-Source: APXvYqw+SJTO66DKH27c9dfEllecXikarseDe+MaLyBem4WIgSQ3PylD2iXpSm79hGUwrpzil23V1Q==
X-Received: by 2002:a17:90a:3d03:: with SMTP id h3mr4514134pjc.49.1568720795265;
        Tue, 17 Sep 2019 04:46:35 -0700 (PDT)
Received: from icarus ([2001:268:c146:aa9b:3c4d:1cfb:4e0b:ea1])
        by smtp.gmail.com with ESMTPSA id o11sm1952043pjp.13.2019.09.17.04.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 04:46:34 -0700 (PDT)
Date:   Tue, 17 Sep 2019 20:46:15 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [RFC/PATCH] counter: introduce support for Intel QEP Encoder
Message-ID: <20190917114403.GA8368@icarus>
References: <20190916093431.264504-1-felipe.balbi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190916093431.264504-1-felipe.balbi@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Sep 16, 2019 at 12:34:31PM +0300, Felipe Balbi wrote:
> Add support for Intel PSE Quadrature Encoder
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> ---
> 
> Hi William,
> 
> Here's a first cut of the ported driver. Note that this is really an RFC as
> there's still quite a bit I don't fully understand. I've left some of my old
> sysfs files in there just to keep track of which features I'm still missing.

Hi Felipe,

That is understandable since this is an RFC; I expect in your final
version those sysfs files will be Counter subsystem extension
attributes.

For reference, the existing Counter subsystem attributes are documented
in the Documentation/ABI/testing/sysfs-bus-counter file. If you have any
new attributes specific to the Intel QEP driver, add them as a new
Documentation/ABI/testing/sysfs-bus-counter-intel-qep file.

> If understood this correctly, I should add noise filtering as a signal
> extension, right? Same for Input Swap.

Determining the type of extension to create is a matter of scope.

* Signal extensions are attributes which expose information/control
  specific to a Signal. These types of attributes will exist under a
  Signal's directory in sysfs.

  For example, if have an invert feature for a Signal, you can have a
  Signal extension called "invert" that toggles that feature:
  /sys/bus/counter/devices/counterX/signalY/invert

* Count extensions are attributes which expose information/control
  specific to a Count. These type of attributes will exist under a
  Count's directory in sysfs.

  For example, if you want to pause/unpause a Count from updating, you
  could have a Count extension called "enable" that toggles such:
  /sys/bus/counter/devices/counterX/countY/enable

* Device extensions are attributes which expose information/control
  non-specific to a particular Count or Signal. This is where you would
  put your global features or other miscellanous functionality.

  For example, if your device has an overtemp sensor, you could report
  the chip overheated via a device extension called "error_overtemp":
  /sys/bus/counter/devices/counterX/error_overtemp

I'm not very familiar with the Intel QEP features, so I'll need your
help clarifying some of it for me. I'm assuming "noise filtering" is
a feature you can enable per individual Signal (is this correct?). If
so, then it would be implemented as a Signal extension, maybe as a
/sys/bus/counter/devices/counterX/signalY/noise_filter_enable file.
Otherwise, it would be a device attribute if it enables noise filtering
over all Signals.

Is "Input Swap" swapping the Phase A and Phase B signal lines for each
Count? If so, this would be a Count extension if you can configure it
per Count; otherwise a device extension if it's globally enabled for all
Counts.

If you're still having trouble figuring out which type of extension to
use, give me a simple breakdown of the features you are trying to
support with these attributes and I should be able to specify which type
works best for each.
 
> How should we handle the reset mode of the device? And mode of operation?

Is "reset mode" specifying the condition that causes a Count's count to
be reset back to a value of 0? If so, I assume "index" means an active
level on the index line will reset the count; does "maximum" mean the
index line is ignored and the reset operation is simply activated once
the ceiling is reached? As well, I'm assuming this is a global
configuration for all counts.

If my assumptions are correct here, then this behavior can be exposed
by creating two device extensions: "preset" and "preset_enable"; these
should be based on the existing two same-named Count attributes (see the
Documentation/ABI/testing/sysfs-bus-counter file).

* /sys/bus/counter/devices/counterX/preset
  For the Intel QEP, this will be a read-only that always report "0".

* /sys/bus/counter/devices/counterX/preset_enable
  Assuming "maximum" is just equivalent to ignoring index, preset_enable
  can toggle between the two modes as a simple boolean: "1" = "index"
  and "0" = "maximum".

  If I assumed incorrectly, please let me know and we can discuss the
  possibility of a new attribute (perhaps "preset_mode").

Take a look inside 104-quad-8.c to see how it handles index lines and
reseting the counts; "preset" and "preset_enable" extensions are
specified in the quad8_count_ext array.

> If you have any ideas, let me know.
> 
> cheers

Since I expect a good amount of this code to change once the extensions
are added, I'll hold off on a more in-depth code review until we get it
closer to what it'll actually look like. From skimming the code in this
RFC, it seems like you have the core Counter subsystem functions and
structures use correct, so I think it'll be the implementations of the
extensions that we'll be focusing on.

William Breathitt Gray
