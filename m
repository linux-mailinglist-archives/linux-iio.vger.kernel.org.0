Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BFF2B95EC
	for <lists+linux-iio@lfdr.de>; Thu, 19 Nov 2020 16:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgKSPQ2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Nov 2020 10:16:28 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:49017 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgKSPQ1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Nov 2020 10:16:27 -0500
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id BEE151C000C;
        Thu, 19 Nov 2020 15:16:24 +0000 (UTC)
Message-ID: <96e2c4ebd7e826b6ea52f72f301fb5e8c33479d5.camel@hadess.net>
Subject: Re: [External] Using IIO to export laptop palm-sensor and lap-mode
 info to userspace?
From:   Bastien Nocera <hadess@hadess.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Pearson <markpearson@lenovo.com>,
        linux-iio@vger.kernel.org, Nitin Joshi1 <njoshi1@lenovo.com>,
        linux-input@vger.kernel.org
Date:   Thu, 19 Nov 2020 16:16:24 +0100
In-Reply-To: <20201112062348.GF1003057@dtor-ws>
References: <9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com>
         <5a646527-7a1f-2fb9-7c09-8becdbff417b@lenovo.com>
         <20201007083602.00006b7e@Huawei.com>
         <218be284-4a37-e9f9-749d-c126ef1d098b@redhat.com>
         <20201112062348.GF1003057@dtor-ws>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2020-11-11 at 22:23 -0800, Dmitry Torokhov wrote:
> <snip>
> I am not sure if multiplexing all proximity switches into one evdev
> node
> is that great option, as I am sure we'll soon have devices with 2x
> palmrest switches and being capable finely adjusting transmit power,
> etc.

Hans, Mark, so is there a consensus to how we should export the "lap-
mode"?

I had nearly finished working on updated code and all the test suite
changes needed to use an input device with switches when IIO started
being discussed, so I stopped in my tracks.

