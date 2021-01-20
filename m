Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012E52FCF53
	for <lists+linux-iio@lfdr.de>; Wed, 20 Jan 2021 13:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbhATLWE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Jan 2021 06:22:04 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:52653 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732958AbhATKWU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Jan 2021 05:22:20 -0500
X-Originating-IP: 82.255.60.242
Received: from [192.168.1.150] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 95BE32001B;
        Wed, 20 Jan 2021 10:21:34 +0000 (UTC)
Message-ID: <aab4d104fc358ce21f8ef69377e203043e700879.camel@hadess.net>
Subject: Re: "light" channel not working in hid-sensor-hub
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Date:   Wed, 20 Jan 2021 11:21:34 +0100
In-Reply-To: <194e35b5acefbb3f7f4092e5d5e46ce5e541cc19.camel@hadess.net>
References: <194e35b5acefbb3f7f4092e5d5e46ce5e541cc19.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2021-01-18 at 21:06 +0100, Bastien Nocera wrote:
> Hey,
> 
> It seems that the "light" channel that's available in hid-sensor-hub
> stopped working quite some time ago. I've tested this on a ColorHug
> ALS
> light sensor, as well as on the light sensor part of the HID sensor
> hub
> on a Surface 3.

Using hid-recorder on the ColorHugALS device, after unloading the hid-
sensor-hub code after the device isn't outputting any useful data:
D: 0
R: 269 05 20 09 01 a1 01 09 41 a1 00 85 01 0a 09 03 15 00 25 01 75 08
95 01 a1 02 0a 31 08 0a 32 08 b1 00 c0 0a 16 03 15 00 25 02 a1 02 0a 40
08 0a 41 08 0a 42 08 b1 00 c0 0a 19 03 15 00 25 02 a1 02 0a 50 08 0a 51
08 0a 52 08 b1 00 c0 0a 01 02 15 00 25 06 a1 02 0a 00 08 0a 01 08 0a 02
08 0a 03 08 0a 04 08 0a 05 08 0a 06 08 b1 00 c0 0a 0e 03 15 00 27 ff ff
ff ff 75 20 55 00 b1 02 05 20 0a 01 02 15 00 25 05 75 08 95 01 a1 02 0a
00 08 0a 01 08 0a 02 08 0a 03 08 0a 05 08 0a 06 08 81 00 c0 0a 02 02 15
00 25 04 a1 02 0a 10 08 0a 11 08 0a 12 08 0a 13 08 0a 14 08 81 00 c0 0a
d1 04 15 00 26 ff ff 75 20 55 0e 81 02 06 c0 ff 09 02 a1 01 85 02 09 01
09 0d 09 03 95 03 b1 22 09 05 75 10 95 01 b1 22 c0 09 03 a1 01 85 03 09
30 75 08 95 01 b1 22 09 07 75 30 95 01 b1 22 09 0b 75 20 b1 22 09 24 09
28 75 08 95 02 c0 c0 c0
N: Hughski Ltd. ColorHugALS
P: usb-0000:00:14.0-10/input0
I: 3 273f 1008
D: 0
E: 0.000001 7 01 01 03 00 00 00 00
E: 0.663922 7 01 01 03 00 00 00 00
E: 1.327952 7 01 01 03 00 00 00 00
E: 1.991027 7 01 01 03 00 00 00 00
E: 2.654949 7 01 01 03 00 00 00 00
E: 3.318928 7 01 01 03 00 00 00 00
E: 3.982937 7 01 01 03 00 00 00 00
etc.

So it's possible that, in this case, the problem lies in the HID core.

Cheers

