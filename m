Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57A4285E6A
	for <lists+linux-iio@lfdr.de>; Wed,  7 Oct 2020 13:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgJGLqe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Oct 2020 07:46:34 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:44062 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgJGLqe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Oct 2020 07:46:34 -0400
Received: from relay4-d.mail.gandi.net (unknown [217.70.183.196])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 719AA3B260B;
        Wed,  7 Oct 2020 11:36:19 +0000 (UTC)
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id CDC89E0008;
        Wed,  7 Oct 2020 11:35:55 +0000 (UTC)
Message-ID: <b400b6956270a2433373dd6cbdae3332aa683f4f.camel@hadess.net>
Subject: Re: [External] Using IIO to export laptop palm-sensor and lap-mode
 info to userspace?
From:   Bastien Nocera <hadess@hadess.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Mark Pearson <markpearson@lenovo.com>
Cc:     linux-iio@vger.kernel.org, Nitin Joshi1 <njoshi1@lenovo.com>,
        linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Date:   Wed, 07 Oct 2020 13:35:55 +0200
In-Reply-To: <218be284-4a37-e9f9-749d-c126ef1d098b@redhat.com>
References: <9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com>
         <5a646527-7a1f-2fb9-7c09-8becdbff417b@lenovo.com>
         <20201007083602.00006b7e@Huawei.com>
         <218be284-4a37-e9f9-749d-c126ef1d098b@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.0 (3.38.0-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2020-10-07 at 11:51 +0200, Hans de Goede wrote:
> <snip>
> > Dmitry, any existing stuff like this in input?
> 
> There already is a SW_FRONT_PROXIMITY defined in
> input-event-codes.h, which I guess means detection if
> someone is sitting in front of the screen. So we could add:
> 
> SW_LAP_PROXIMITY
> SW_PALMREST_PROXIMITY,
> 
> And then we have a pretty decent API for this I think.

From the point of view of writing the consumer code for this API, it's
rather a lot of pain to open the device node (hoping that it's the
right one for what we need), getting the initial state, setting up
masks to avoid being woken up for every little event, and parsing those
events.

Where would the necessary bits of metadata for daemons to be able to
find that those switches need to get added?

If you go down that route, you'll definitely want a want to attach the
"palmrest" to the touchpad/keyboard that it corresponds to, otherwise
that might have weird interactions when using external keyboards and
touchpads. (I don't know what you'd use that proximity sensor for
though)

Cheers

