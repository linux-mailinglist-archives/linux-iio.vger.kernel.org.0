Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8742E92C5
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jan 2021 10:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbhADJqi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Jan 2021 04:46:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:43476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbhADJqi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 4 Jan 2021 04:46:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CCD021D7F;
        Mon,  4 Jan 2021 09:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609753557;
        bh=xhcxGU73opBaxA6SLb2C6H6HREW/m2aBOHhnWIGGbBc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Vu0het6HhXFKFPLHYqh3DCPGfnocBX8WWdqpP99S1NG0TfJOsj57NyJV2EccbvsZ0
         DeLkCbm5AH4MTGxdd2OcpHEK4red+ekp5IDDjuBMXG9Ae4K7EnLPW2UQnh0U7+xbjv
         FLWEUcFtwjQzClFws3vpAwcqcxXoGCpgTn20OCrZFE1bcxMZQh2uI4Fk6U8ejt/agi
         T6Dp8xXuK8/nfHB2TaR9COhBLv1xIjj0d1huqJj9fU56MVS7IUlcquOizMfQbA2az6
         lAAEXaku4525xfpcZlb0EpTX7VHbZu76Uv1M/uy8RQPNVGBPiHpAPoWAi/RXPrJZBU
         zyCyVBiPB+adg==
Date:   Mon, 4 Jan 2021 10:45:54 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Ye Xiang <xiang.ye@intel.com>
cc:     jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] HID: hid-sensor-custom: Add custom sensor iio
 support
In-Reply-To: <20201215054444.9324-2-xiang.ye@intel.com>
Message-ID: <nycvar.YFH.7.76.2101041045320.25826@cbobk.fhfr.pm>
References: <20201215054444.9324-1-xiang.ye@intel.com> <20201215054444.9324-2-xiang.ye@intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Dec 2020, Ye Xiang wrote:

> Currently custom sensors properties are not decoded and it is up to
> user space to interpret.
> 
> Some manufacturers already standardized the meaning of some custom sensors.
> They can be presented as a proper IIO sensor. We can identify these sensors
> based on manufacturer and serial number property in the report.
> 
> This change is identifying hinge sensor when the manufacturer is "INTEL".
> This creates a platform device so that a sensor driver can be loaded to
> process these sensors.
> 
> Signed-off-by: Ye Xiang <xiang.ye@intel.com>

Acked-by: Jiri Kosina <jkosina@suse.cz>

Jonathan, feel free to take this with the rest through your tree. Thanks,

-- 
Jiri Kosina
SUSE Labs

