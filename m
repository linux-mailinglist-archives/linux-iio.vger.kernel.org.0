Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20F6719A13
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2019 10:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfEJI5C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 May 2019 04:57:02 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:42755 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfEJI5C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 May 2019 04:57:02 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 847936000D;
        Fri, 10 May 2019 08:56:56 +0000 (UTC)
Message-ID: <55468fdd88da9f487789b2073a1babb14bc7a282.camel@hadess.net>
Subject: Re: [RFC v3] iio: input-bridge: optionally bridge iio acceleometers
 to create a /dev/input interface
From:   Bastien Nocera <hadess@hadess.net>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eric Piel <eric.piel@tremplin-utc.net>,
        linux-input@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Date:   Fri, 10 May 2019 10:56:55 +0200
In-Reply-To: <AA2B43FE-E196-4FEC-B4C5-897D0F44A76F@goldelico.com>
References: <d52cf9ee5944c90c69f6e74a46d844cef51e487e.1555362312.git.hns@goldelico.com>
         <0189da8d91652dd3ecf729b03029ab9db5a24f99.camel@hadess.net>
         <AA2B43FE-E196-4FEC-B4C5-897D0F44A76F@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 (3.32.1-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2019-04-16 at 21:33 +0200, H. Nikolaus Schaller wrote:
> Hi Bastien,
> 
> > Am 16.04.2019 um 18:04 schrieb Bastien Nocera <hadess@hadess.net>:
> > This can be done in user-space, reading the data from the IIO driver,
> > and using uinput to feed it back. Why is doing this at the kernel level
> > better?
> 
> Well, I'd estimate that >80% of the current kernel could be done in user-space
> (but not at the same speed/quality).
> 
> E.g. TCP could most likely be done by directly accessing the Ethernet layer and
> providing other processes access through named pipes instead of sockets.
> 
> But usually a user-space daemon feeding things back into the kernel is slower
> (because it is scheduled differently) and needs more resources for running the
> process and IPC and is less protected against hickups and deadlocks.

This is mostly irrelevant for the amount of data we're treating, but it
doesn't matter too much.

> Two more aspects come to my mind from reading your project page:
> 
> a) "It requires libgudev and systemd"
> b) "Note that a number of kernel bugs will prevent it from working correctly"
> 
> a) this makes quite significant assumptions about the user-space while a kernel
>    driver can be kept independent of this

It's made for modern desktop OSes/"traditional" Linux. I don't think
that those 2 libraries are problematic dependencies unless you're on
Android, where a replacement could be implemented or iio-sensor-proxy
modified for that use case.

> b) if it is in-kernel it will be kept in sync with kernel changes and such bugs
>    are less likely

No they're not. This warning was because 1) drivers sometimes have bugs
2) user-space sometimes has bugs 3) user-space sometimes causes the
kernel to have bugs.

The 2 significant breakages for iio-sensor-proxy were caused by runtime
PM bugs in the hid-sensor-hub driver, and in the USB core. I doubt a
kernel-space implementation would have been able to magically fix those
bugs unfortunately.

