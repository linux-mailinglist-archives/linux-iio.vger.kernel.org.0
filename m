Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3951D665B31
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jan 2023 13:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjAKMQw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Jan 2023 07:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbjAKMQp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Jan 2023 07:16:45 -0500
X-Greylist: delayed 420 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 11 Jan 2023 04:16:43 PST
Received: from frolo.macqel.be (smtp2.macqel.be [109.135.2.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D1E4C31
        for <linux-iio@vger.kernel.org>; Wed, 11 Jan 2023 04:16:43 -0800 (PST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id 3B1EDDF00AE; Wed, 11 Jan 2023 13:09:39 +0100 (CET)
Date:   Wed, 11 Jan 2023 13:09:40 +0100
From:   Philippe De Muyter <phdm@macq.eu>
To:     lorenzo@kernel.org, linux-iio@vger.kernel.org
Subject: sysfs mount_matrix for st_lsm6dsx gyro
Message-ID: <20230111120940.GA23351@frolo.macqel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_40,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Lorenzo and list,

I do not find a "*mount_matrix" entry in sysfs for a 'ism330dlc_gyro'
iio device.
Is that normal ?
Is a fix available ?

Some more info :

I have backported  drivers/iio/imu/st_lsm6dsx to linux-4.9 in order
to drive a ism330dlc imu on a custom board.  The chip is correctly
detected and two devices are created in /sys/bus/iio/devices/

the first one (where name is 'ism330dlc_gyro') has the following entries :

 me@proto4:~$ ls /sys/bus/iio/devices/iio\:device1/
 buffer                      in_anglvel_x_raw  sampling_frequency
 current_timestamp_clock     in_anglvel_y_raw  sampling_frequency_available
 dev                         in_anglvel_z_raw  scan_elements
 in_anglvel_scale            name              subsystem
 in_anglvel_scale_available  power             uevent
 me@proto4:~$

the second one (where name is 'ism330dlc_accel') has those entries :

 me@proto4:~$ ls /sys/bus/iio/devices/iio\:device2
 buffer                    in_accel_x_raw  sampling_frequency
 current_timestamp_clock   in_accel_y_raw  sampling_frequency_available
 dev                       in_accel_z_raw  scan_elements
 events                    mount_matrix    subsystem
 in_accel_scale            name            uevent
 in_accel_scale_available  power
 me@proto4:~$

The 'mount_matrix' entry is only present in the 'ism330dlc_accel' device
but not in the 'ism330dlc_gyro' device.

On a similar board, but with mpu9250 imu, I get only one iio:deviceX
entry but with two *mount_matrix entries : 

	in_accel_mount_matrix
	in_anglvel_mount_matrix

In both cases, I would have expected only one 'iio:deviceX' entry with
only one 'mount_matrix' entry.

Best regards

Philippe

-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
