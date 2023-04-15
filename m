Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703196E3300
	for <lists+linux-iio@lfdr.de>; Sat, 15 Apr 2023 19:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjDORu3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Apr 2023 13:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjDORu2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Apr 2023 13:50:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705F035AB
        for <linux-iio@vger.kernel.org>; Sat, 15 Apr 2023 10:50:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E4F560C5E
        for <linux-iio@vger.kernel.org>; Sat, 15 Apr 2023 17:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB627C433D2;
        Sat, 15 Apr 2023 17:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681581026;
        bh=mJdm8iVW/CB2WlBmblOiYsNBpPjf51oHmVraLXhwHJQ=;
        h=Date:From:To:Subject:From;
        b=lsJmbl+V33tqIx4b5xhviJVT3lmkbChhspAP1eLtLk8FOHbFxH5Foyd6Bg4byssEp
         9OAXkHuGjwxiBkim85dfdVOE3FXa5lOZ1iKWRHFvb2/XZki+83h3DCO0xLprhc4Vft
         ug5b4cI4h36Hs3iW5x8q2fdFH6U8eYHsVydNI5Gu86bJHNqtgDNIpkXy8n/vvvyLPy
         pk40IFZlRHhKCO1p2ZgU354rtbAeXZEgxIyJxqDwsq7w9wpC19ZjPNqOjKQO9QN991
         emq0qvqWwW0TyIrZ/UGfs/S6gjs1EhteQ3h1ItpzvTtvgLz83hYXG6QgVEIBflfoR6
         iw8Gh43dnG5Wg==
Date:   Sat, 15 Apr 2023 18:50:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 2nd set of features for the 6.4 cycle.
Message-ID: <20230415185027.60a34106@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit fba51482b6c0a6743b441bd57d53be11beb35a9b:

  Merge tag 'iio-for-6.4a' of https://git.kernel.org/pub/scm/linux/kernel/g=
it/jic23/iio into char-misc-next (2023-04-12 09:45:34 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-6.4b

for you to fetch changes up to 52cc189b4fc6af6accc45fe7b7053d76d8724059:

  iio: adc: palmas: don't alter event config on suspend/resume (2023-04-13 =
12:10:11 +0100)

----------------------------------------------------------------
2nd set of IIO features and cleanups for the 6.4 cycle.

A few more changes. Some were dependent on fixes that are now upstream
and in char-misc-next.

st,lsm6dsx:
 - Add an ACPI ID (SMO8B30) and mount matrix (ROTM) seen in the wild.
ti,palmas
 - Take probe fully devm managed.
 - Add threshold event support (after some rework)
 - Stop changing the event config on suspend and resume.

----------------------------------------------------------------
Jonathan Cameron (3):
      iio: imu: lsm6dsx: Support SMO8B30 ACPI ID for LSM6DS3TR-C
      iio: imu: lsm6dsx: Add ACPI mount matrix retrieval
      iio: adc: palmas: Take probe fully device managed.

Patrik Dahlstr=C3=B6m (7):
      iio: adc: palmas: remove adc_wakeupX_data
      iio: adc: palmas: replace "wakeup" with "event"
      iio: adc: palmas: use iio_event_direction for threshold polarity
      iio: adc: palmas: move eventX_enable into palmas_adc_event
      iio: adc: palmas: always reset events on unload
      iio: adc: palmas: add support for iio threshold events
      iio: adc: palmas: don't alter event config on suspend/resume

 drivers/iio/adc/palmas_gpadc.c               | 615 +++++++++++++++++++++--=
----
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c |  77 +++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  |  16 +-
 include/linux/mfd/palmas.h                   |   8 -
 5 files changed, 566 insertions(+), 152 deletions(-)
