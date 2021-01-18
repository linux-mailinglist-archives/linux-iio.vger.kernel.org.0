Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251E12FAB2C
	for <lists+linux-iio@lfdr.de>; Mon, 18 Jan 2021 21:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437815AbhARUOr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Jan 2021 15:14:47 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:40072 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394295AbhARUOn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jan 2021 15:14:43 -0500
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id C6A853A2300
        for <linux-iio@vger.kernel.org>; Mon, 18 Jan 2021 20:07:16 +0000 (UTC)
X-Originating-IP: 82.255.60.242
Received: from [192.168.1.150] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 0AE93C000D;
        Mon, 18 Jan 2021 20:06:08 +0000 (UTC)
Message-ID: <194e35b5acefbb3f7f4092e5d5e46ce5e541cc19.camel@hadess.net>
Subject: "light" channel not working in hid-sensor-hub
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Date:   Mon, 18 Jan 2021 21:06:08 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hey,

It seems that the "light" channel that's available in hid-sensor-hub
stopped working quite some time ago. I've tested this on a ColorHug ALS
light sensor, as well as on the light sensor part of the HID sensor hub
on a Surface 3.

The accelerometer and the gyro work fine on the Surface 3, but the
light sensor only ever returns zeros when iio-sensor-proxy or the
iio_generic_buffer tools are used:

$ sudo iio_generic_buffer -A -N 0
iio device number being used is 0
iio trigger number being used is 0
Enabling all channels
Enabling: in_intensity_both_en
Enabling: in_illuminance_en
/sys/bus/iio/devices/iio:device0 als-dev0
0.000000 0.000000 
0.000000 0.000000 
0.000000 0.000000 
0.000000 0.000000 
0.000000 0.000000 
Disabling: in_intensity_both_en
Disabling: in_illuminance_en

I believe this has been broken for at least a year. Does anyone know
what the problem could be, or how to get started debugging the
problem? 

I'll probably try checking whether the problem is with the user-space
parsing of the data, rather than the kernel driver.

Cheers

