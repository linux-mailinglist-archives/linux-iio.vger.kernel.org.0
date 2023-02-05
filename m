Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB7A68B08C
	for <lists+linux-iio@lfdr.de>; Sun,  5 Feb 2023 16:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBEPWw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Feb 2023 10:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjBEPWw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Feb 2023 10:22:52 -0500
Received: from frolo.macqel.be (smtp2.macqel.be [109.135.2.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8801170F
        for <linux-iio@vger.kernel.org>; Sun,  5 Feb 2023 07:22:46 -0800 (PST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id B7512DF00BC; Sun,  5 Feb 2023 16:22:44 +0100 (CET)
Date:   Sun, 5 Feb 2023 16:22:44 +0100
From:   Philippe De Muyter <phdm@macq.eu>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lorenzo@kernel.org, linux-iio@vger.kernel.org
Subject: Re: st_lsm6dsx : first two values of ism330dlc_gyro are wrong
Message-ID: <20230205152244.GA13271@frolo.macqel>
References: <20230205101223.GA10729@frolo.macqel> <20230205141342.10dbc447@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230205141342.10dbc447@jic23-huawei>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Feb 05, 2023 at 02:13:42PM +0000, Jonathan Cameron wrote:
> 
> On Sun, 5 Feb 2023 11:12:23 +0100
> Philippe De Muyter <phdm@macq.eu> wrote:
> 
> > I use the imu/st_lsm6dsx (i2c) driver to drive a ism330dlc imu.
> >
> > Every time I start a new acquisition of gyro values, the first two
> > values read are wrong, as can be see here :
> >
> 
> So, some random thoughts on what might be going on...
> 1) Stale data in the fifo.  Could you run this experiment twice whilst being
>    careful not to move the device between the runs.  If we still see the wrong
>    values at the start then it's not that...

Here are the results (I have enabled by hand the three in_anglvel channels)
 # while true; do  sudo iio/iio_generic_buffer -n ism330dlc_gyro -g -c 6 -a; sleep 2; done
 iio device number being used is 1
 trigger-less mode selected
 Auto-channels selected but some channels are already activated in sysfs
 Proceeding without activating any channels
 -0.133416 -0.916011 0.466650
 -0.014382 -0.360774 0.140454
 -0.000612 -0.076653 0.035190
 -0.000459 -0.076347 0.035496
 -0.000306 -0.076347 0.035037
 -0.000612 -0.076347 0.035037
 iio device number being used is 1
 trigger-less mode selected
 Auto-channels selected but some channels are already activated in sysfs
 Proceeding without activating any channels
 -0.134640 -0.911880 0.467415
 -0.013923 -0.361233 0.142443
 -0.000765 -0.076041 0.035496
 -0.000459 -0.076041 0.035190
 -0.000306 -0.076347 0.035343
 -0.000612 -0.076347 0.035343
 iio device number being used is 1
 trigger-less mode selected
 Auto-channels selected but some channels are already activated in sysfs
 Proceeding without activating any channels
 -0.137853 -0.912645 0.468792
 -0.013770 -0.361233 0.142443
 -0.000153 -0.076500 0.035190
 -0.000306 -0.076347 0.035190
 -0.000306 -0.076194 0.035190
 -0.000153 -0.076194 0.035343
 iio device number being used is 1
 trigger-less mode selected
 Auto-channels selected but some channels are already activated in sysfs
 Proceeding without activating any channels
 -0.136017 -0.914787 0.467874
 -0.014229 -0.361080 0.142290
 -0.000153 -0.076500 0.035649
 0.000918 -0.076347 0.039933
 0.000306 -0.076500 0.038556
 0.000459 -0.076194 0.036414
 iio device number being used is 1
 trigger-less mode selected
 Auto-channels selected but some channels are already activated in sysfs
 Proceeding without activating any channels
 -0.133722 -0.914787 0.469710
 -0.013617 -0.361386 0.142290
 -0.000459 -0.076347 0.035037
 -0.000459 -0.076194 0.035190
 -0.000459 -0.075888 0.035037
 -0.000612 -0.076347 0.035649
 iio device number being used is 1
 trigger-less mode selected
 Auto-channels selected but some channels are already activated in sysfs
 Proceeding without activating any channels
 -0.135711 -0.915399 0.468792
 -0.013923 -0.360927 0.142137
 -0.000459 -0.076347 0.035343
 -0.000459 -0.076194 0.035190
 -0.000306 -0.076041 0.035496
 -0.000459 -0.075888 0.035190
 ^C

> 
> 2) Device takes a little whilst to stabilize. Possibly this is down to the
>    low pass filters requiring a few samples before they deliver stable output.
>    From a quick glance I don't think we provide any userspace control of those
>    filters and I think LPR1 is left in default state of disabled.
> 
> You could try messing with the sampling frequency as that may affect the number
> of bad samples you see and give us more of a clue (it affects lpf2 directly).

Above is with default sampling frequency : 12.5

with 26, I get also two bad values, but different from the previous ones :

 Proceeding without activating any channels
 -0.242811 -1.215279 0.709155
 -0.055539 -1.216197 0.466650
 0.002142 -0.075582 0.034578
 0.002142 -0.075123 0.035955
 0.002295 -0.075582 0.036261
 0.002142 -0.075429 0.035955
 
with 52, I now get more bad values :
 
 Proceeding without activating any channels
 -0.267750 -0.745569 0.558909
 -0.486999 -3.376863 1.719567
 0.130815 -0.705942 0.054315
 0.001989 -0.075582 0.036414
 0.001224 -0.075123 0.035955
 0.001836 -0.075888 0.036108
 0.002448 -0.075582 0.036261
 0.002295 -0.075888 0.035190
 0.002295 -0.075888 0.036261
 0.002907 -0.075888 0.036261
 
with 106, I get evenmore bad values
 
 Proceeding without activating any channels
 -0.024174 -0.082773 -0.154377
 -0.412335 -0.387702 0.665856
 -0.450432 -2.840751 1.692486
 -1.784439 -4.931190 4.186539
 -1.090125 -4.231215 2.580345
 0.674730 -3.370896 0.127908
 0.562275 -2.838456 0.115209
 0.085680 -0.486846 0.045900
 0.003825 -0.081702 0.040392
 0.004437 -0.078030 0.037179
 0.004284 -0.076806 0.036261
 0.003213 -0.075735 0.035343
 0.003672 -0.075735 0.035343
 0.002295 -0.074970 0.036567
 0.002448 -0.076041 0.037179
 0.002448 -0.076347 0.037179
 0.002142 -0.076347 0.037332
 0.001989 -0.076194 0.036108
 0.001989 -0.076194 0.035955
 0.002142 -0.075276 0.036106

Philippe
