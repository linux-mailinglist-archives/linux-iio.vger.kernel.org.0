Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9F3694283
	for <lists+linux-iio@lfdr.de>; Mon, 13 Feb 2023 11:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjBMKRA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Feb 2023 05:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjBMKQ7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Feb 2023 05:16:59 -0500
Received: from frolo.macqel.be (smtp2.macqel.be [109.135.2.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E3D21BCD
        for <linux-iio@vger.kernel.org>; Mon, 13 Feb 2023 02:16:56 -0800 (PST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id B83E2DF00A8; Mon, 13 Feb 2023 11:16:54 +0100 (CET)
Date:   Mon, 13 Feb 2023 11:16:54 +0100
From:   Philippe De Muyter <phdm@macq.eu>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, jic23@kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: no answer after some
        iio_generic_buffer test cycles
Message-ID: <20230213101654.GA5438@frolo.macqel>
References: <1228b9ed2060b99d0df0f5549a37c8b520ea5429.1675867224.git.lorenzo@kernel.org> <Y+i9rImVqH7iVets@lore-desk> <20230213091957.GA4925@frolo.macqel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213091957.GA4925@frolo.macqel>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Lorenzo,

On Mon, Feb 13, 2023 at 10:19:57AM +0100, Philippe De Muyter wrote:
> I have a bug, with our without the patch : frequently
> my test, using a loop around iio-generic-buffer, blocks on the poll syscall.
> No value comes anymore.  This happens both with the gyro as with the accel
> component.
> 
> More info follows.

Here is the way I test :

 # iio/lsiio 
 Device 001: ism330dlc_gyro
 Device 002: ism330dlc_accel
 Device 000: ina3221x
 # for axis in x y z; do echo 1 >/sys/bus/iio/devices/iio\:device1/scan_elements/in_anglvel_${axis}_en; done
 # echo 416 > /sys/bus/iio/devices/iio\:device1/sampling_frequency
 # while true; do  sudo iio/iio_generic_buffer -n ism330dlc_gyro -g -c 6 -a; sleep 2; done
 iio device number being used is 1
 trigger-less mode selected
 Auto-channels selected but some channels are already activated in sysfs
 Proceeding without activating any channels
 0.002291 -0.073762 0.033139 
 0.003971 -0.075289 0.035583 
 0.003971 -0.076969 0.036194 
 0.004123 -0.074220 0.037110 
 0.003207 -0.074678 0.034667 
 0.002596 -0.073456 0.035277 
 iio device number being used is 1
 trigger-less mode selected
 Auto-channels selected but some channels are already activated in sysfs
 Proceeding without activating any channels
 0.002138 -0.074067 0.034819 
 0.003512 -0.075442 0.034819 
 0.001985 -0.074373 0.035430 
 0.002902 -0.074373 0.035888 
 0.002138 -0.074220 0.036346 
 0.003360 -0.076053 0.035277

After a quick time, iio_generic_buffer gets blocked in the poll syscall.
Hitting 'CTRL-C' kills the iio_generic_buffer process, and the next one
then receives values.

This happens with both gyro and accel.

Do you encounter the same problem ?

My kernel is actually a 4.9 one with a backport of iio core infrastructure
and iio/imu/st_lsm6dsx of 6.2, but I could have missed something important.

Best regards

Philippe
