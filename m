Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509E67A8653
	for <lists+linux-iio@lfdr.de>; Wed, 20 Sep 2023 16:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbjITONs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Sep 2023 10:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjITONr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Sep 2023 10:13:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54A599;
        Wed, 20 Sep 2023 07:13:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0484BC433C8;
        Wed, 20 Sep 2023 14:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695219221;
        bh=+PIFdd9Ls/XOzLa7S2SXFO9aN6ielA4li7g11WQ+L7I=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=DSOSs61VmibAnne4RhZeh43rOX4CSjaKCt2WTZvQwh2wnCeLnmzxHLhb83Uavyc1n
         528xsWrdm4emPruaJq6h9f8v6VSSJzP1QIDojXVrESGeH0fllMiEIebeJZmnEBQdF6
         KDPpMBlB3elkQ5sGCJSWcJqQKgy7EX6dC423QRH9glrq1LWkKbPoZYZtzs+Yvi9FZW
         Fw86IduZobavDyfPK+dikbtF7W/5OPbRY6c9cEz05htFy97ZEg4ZL39Gwu8jIE0nPi
         Vegfk24Wp3CCmdgEuIF68vJJAUuDu/t6dIFaYF9m6rQXQD2wJdumwL4zYkIeIKGY61
         gN+GPQ9VyqHIw==
Date:   Wed, 20 Sep 2023 16:13:37 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
cc:     benjamin.tissoires@redhat.com, jic23@kernel.org, lars@metafoo.de,
        srinivas.pandruvada@linux.intel.com, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 0/9] Support light color temperature and
 chromaticity
In-Reply-To: <20230919081054.2050714-1-Basavaraj.Natikar@amd.com>
Message-ID: <nycvar.YFH.7.76.2309201612350.14216@cbobk.fhfr.pm>
References: <20230919081054.2050714-1-Basavaraj.Natikar@amd.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 Sep 2023, Basavaraj Natikar wrote:

> This series adds support for light color temperature and chromaticity.
> 
> v1->v2:
> *Rename the series.
> *Rename als_illum to als channel as it supports other channels.
> *Update patch description to include same reading for the two existing
>  channels to use channel index to support more hub attributes.
> *Keep line length under 80chars in hid-sensor-als.
> *Add new channel type IIO_COLORTEMP.
> *Update patch description and its subject to add channel type for 
>  chromaticity. 
> 
> Basavaraj Natikar (9):
>   iio: hid-sensor-als: Use channel index to support more hub attributes
>   iio: Add channel type light color temperature
>   iio: hid-sensor-als: Add light color temperature support
>   HID: amd_sfh: Add support for light color temperature
>   HID: amd_sfh: Add support for SFH1.1 light color temperature
>   iio: Add channel type for chromaticity
>   iio: hid-sensor-als: Add light chromaticity support
>   HID: amd_sfh: Add light chromaticity support
>   HID: amd_sfh: Add light chromaticity for SFH1.1
> 
>  Documentation/ABI/testing/sysfs-bus-iio       |  15 ++
>  .../hid_descriptor/amd_sfh_hid_desc.c         |   7 +
>  .../hid_descriptor/amd_sfh_hid_desc.h         |   3 +
>  .../hid_descriptor/amd_sfh_hid_report_desc.h  |  21 +++
>  drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c |   9 ++
>  .../amd-sfh-hid/sfh1_1/amd_sfh_interface.h    |  15 ++
>  drivers/iio/industrialio-core.c               |   2 +
>  drivers/iio/light/hid-sensor-als.c            | 130 +++++++++++++++---
>  include/linux/hid-sensor-ids.h                |   4 +
>  include/uapi/linux/iio/types.h                |   2 +
>  tools/iio/iio_event_monitor.c                 |   3 +
>  11 files changed, 195 insertions(+), 16 deletions(-)

I believe this should go through Jonathan's tree as a whole, right?

Thanks,

-- 
Jiri Kosina
SUSE Labs

