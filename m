Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1850B332B92
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 17:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhCIQJM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 11:09:12 -0500
Received: from mga17.intel.com ([192.55.52.151]:10248 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231976AbhCIQIk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 9 Mar 2021 11:08:40 -0500
IronPort-SDR: GW0EPtWTJBPmRBpKJIXo9Gu0lhHO3irB7a8Yw7ZlbgNT5bjosdyIEO7RY4nBykQzYJkIRjGpWA
 TaNMRqAg5hVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9918"; a="168180157"
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="168180157"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 08:08:37 -0800
IronPort-SDR: +i6VdVFC9GL00rPRtx/bSqZoPfXP6nEUAghQhRFtwTYUrFxfvcOMYzi+up9usmYI31CNX1xyJE
 VmqM3HnIfwRw==
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="369832696"
Received: from sastanle-desk2.amr.corp.intel.com ([10.212.154.75])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 08:08:36 -0800
Message-ID: <69475ef69096587be23f632e79efce5711c82cf1.camel@linux.intel.com>
Subject: Re: [PATCH] HID: intel_ish-hid: HBM: Use connected standby state
 bit during suspend/resume
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Ye, Xiang" <xiang.ye@intel.com>, Jiri Kosina <jikos@kernel.org>
Cc:     jic23@kernel.org, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 09 Mar 2021 08:08:36 -0800
In-Reply-To: <20210309034742.GA18299@host>
References: <20210303062825.7724-1-xiang.ye@intel.com>
         <nycvar.YFH.7.76.2103081125380.12405@cbobk.fhfr.pm>
         <00ad0906b90a290e9737b7bf7d8c5ab9c6ed61e6.camel@linux.intel.com>
         <20210309034742.GA18299@host>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2021-03-09 at 11:47 +0800, Ye, Xiang wrote:
> Hi Srinivas, Jiri
> 
> On Mon, Mar 08, 2021 at 08:00:41AM -0800, Srinivas Pandruvada wrote:
> > On Mon, 2021-03-08 at 11:26 +0100, Jiri Kosina wrote:
> > > On Wed, 3 Mar 2021, Ye Xiang wrote:
> > > 
> > > > ISH firmware uses connected standby state bit
> > > > (CONNECTED_STANDBY_STATE_BIT bit 1)
> > > > to notify current power state to sensors instead of suspend
> > > > state
> > > > bit (bit 0).
> > > > So send both SUSPEND_STATE_BIT and CONNECTED_STANDBY_STATE_BIT
> > > > to
> > > > firmware
> > > > to be compatible with the previous version.
> > > 
> > > Could you please make the changelog more verbose -- namely what 
> > > user-visible issue this is fixing?
> > Xiang,
> > 
> > I think this change is for related to Elkhart Lake for support of
> > connected standby (keep listening for sensor events during Linux
> > suspend for some sensors). In this way some sensor can wake up the
> > system.
> This change is for all ISH platform. Currently, ISH firmware use
> both SUSPEND_STATE_BIT and CONNECTED_STANDBY_STATE_BIT to identify
> system state. It is related to system wake up by ISH and it enable
> each
> sensor in ISH to be notified the current system state, when system
> state
> change.
What will sensors do with this additional information?
I think the individual sensors in ISH can decide whether to power OFF
or ON based on this information to save power during system suspend to
idle.

Thanks,
Srinivas

> 
> Thanks
> Ye Xiang
> > 
> > 
> > 
> > 
> > 
> > 

