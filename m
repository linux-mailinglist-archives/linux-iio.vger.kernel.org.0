Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657EC7A3551
	for <lists+linux-iio@lfdr.de>; Sun, 17 Sep 2023 13:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjIQLJi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Sep 2023 07:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjIQLJY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Sep 2023 07:09:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA13B8;
        Sun, 17 Sep 2023 04:09:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E11AC433C8;
        Sun, 17 Sep 2023 11:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694948958;
        bh=vsPwloe7DP8GwXtumCfNTSPOWNOw1im3N9X53NttwHI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bI6vVy3VkY1lJP18zla+uS5EqF5Iq1yIzCrOuEPmnbQlx0ZkynXy1KaCQpELzeSrf
         tb5fO7CPNKaDd1dAqwC+8wtbK1Yc9JCp3pBUVbN3CNBYZv+S+xG1fwzLO6H+7l1QRA
         EdMP4yPTKMRVDLzpQOTi5KY44n9cG3K/7SVMRRsUYWV7zW0iTcgpSyrAjfj3eNJeI6
         biUXtJeigV9wkI+AXu61Uts/hi5Ssaetz8IrPwVuM/qKAL6865W9P4hzdDM1RYqVWY
         NpvV5IgKngcSf5b8zBmZ+DyDMmVk5HDkyWoPRVpKG7OIQExezLbi2a6Na+AV4qNY+r
         VHE+xy4cnEdkQ==
Date:   Sun, 17 Sep 2023 12:09:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <lars@metafoo.de>, <srinivas.pandruvada@linux.intel.com>,
        <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 0/8] Multiple light sensor support
Message-ID: <20230917120910.6f6c5a96@jic23-huawei>
In-Reply-To: <20230915051703.1689578-1-Basavaraj.Natikar@amd.com>
References: <20230915051703.1689578-1-Basavaraj.Natikar@amd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Sep 2023 10:46:55 +0530
Basavaraj Natikar <Basavaraj.Natikar@amd.com> wrote:

> This series adds support for light color temperature and chromaticity.

Hi Basavaraj,

I'd rename the series to make it clearer that this is about adding
colour temperature and chromaticity support rather than simply lots
of boring ambient light sensors.

Jonathan

> 
> Basavaraj Natikar (8):
>   iio: hid-sensor-als: Use channel index to support more hub attributes
>   iio: hid-sensor-als: Add light color temperature support
>   HID: amd_sfh: Add support for light color temperature
>   HID: amd_sfh: Add support for SFH1.1 light color temperature
>   iio: Add channel for chromaticity
>   iio: hid-sensor-als: Add light chromaticity support
>   HID: amd_sfh: Add light chromaticity support
>   HID: amd_sfh: Add light chromaticity for SFH1.1
> 
>  Documentation/ABI/testing/sysfs-bus-iio       |   8 ++
>  .../hid_descriptor/amd_sfh_hid_desc.c         |   7 +
>  .../hid_descriptor/amd_sfh_hid_desc.h         |   3 +
>  .../hid_descriptor/amd_sfh_hid_report_desc.h  |  21 +++
>  drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c |   9 ++
>  .../amd-sfh-hid/sfh1_1/amd_sfh_interface.h    |  15 +++
>  drivers/iio/industrialio-core.c               |   1 +
>  drivers/iio/light/hid-sensor-als.c            | 124 +++++++++++++++---
>  include/linux/hid-sensor-ids.h                |   4 +
>  include/uapi/linux/iio/types.h                |   1 +
>  tools/iio/iio_event_monitor.c                 |   2 +
>  11 files changed, 180 insertions(+), 15 deletions(-)
> 

