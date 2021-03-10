Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8863B3333FE
	for <lists+linux-iio@lfdr.de>; Wed, 10 Mar 2021 04:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhCJDyd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 22:54:33 -0500
Received: from mga06.intel.com ([134.134.136.31]:24151 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230490AbhCJDyD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 9 Mar 2021 22:54:03 -0500
IronPort-SDR: hStkhkf7GJYsFwOd8Fu/qIiV699gIVm6ZVeL7XppthgJFXRX0D31bl3reSElQcnVC+OoXC/LsX
 qnuHQP0PaNkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="249748576"
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="249748576"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 19:54:02 -0800
IronPort-SDR: RQlRl0VRyHn4PBQXV3ZWUtxjQ3xYKNUd7OZLWbyyUUSj7AJmZCGsJ1eaaI+W2JhRaSPEwvIhtg
 kuljbo25p2BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="602908986"
Received: from host.sh.intel.com (HELO host) ([10.239.154.115])
  by fmsmga005.fm.intel.com with ESMTP; 09 Mar 2021 19:54:00 -0800
Date:   Wed, 10 Mar 2021 11:56:04 +0800
From:   "Ye, Xiang" <xiang.ye@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Jiri Kosina <jikos@kernel.org>, jic23@kernel.org,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xu@host, Even <even.xu@intel.com>,
        "Ye, Xiang" <xiang.ye@intel.com>
Subject: Re: [PATCH] HID: intel_ish-hid: HBM: Use connected standby state bit
 during suspend/resume
Message-ID: <20210310035604.GA28978@host>
References: <20210303062825.7724-1-xiang.ye@intel.com>
 <nycvar.YFH.7.76.2103081125380.12405@cbobk.fhfr.pm>
 <00ad0906b90a290e9737b7bf7d8c5ab9c6ed61e6.camel@linux.intel.com>
 <20210309034742.GA18299@host>
 <69475ef69096587be23f632e79efce5711c82cf1.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69475ef69096587be23f632e79efce5711c82cf1.camel@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Srinivas

Thanks for the review.

On Tue, Mar 09, 2021 at 08:08:36AM -0800, Srinivas Pandruvada wrote:
> On Tue, 2021-03-09 at 11:47 +0800, Ye, Xiang wrote:
> > Hi Srinivas, Jiri
> > 
> > On Mon, Mar 08, 2021 at 08:00:41AM -0800, Srinivas Pandruvada wrote:
> > > On Mon, 2021-03-08 at 11:26 +0100, Jiri Kosina wrote:
> > > > On Wed, 3 Mar 2021, Ye Xiang wrote:
> > > > 
> > > > > ISH firmware uses connected standby state bit
> > > > > (CONNECTED_STANDBY_STATE_BIT bit 1)
> > > > > to notify current power state to sensors instead of suspend
> > > > > state
> > > > > bit (bit 0).
> > > > > So send both SUSPEND_STATE_BIT and CONNECTED_STANDBY_STATE_BIT
> > > > > to
> > > > > firmware
> > > > > to be compatible with the previous version.
> > > > 
> > > > Could you please make the changelog more verbose -- namely what 
> > > > user-visible issue this is fixing?
> > > Xiang,
> > > 
> > > I think this change is for related to Elkhart Lake for support of
> > > connected standby (keep listening for sensor events during Linux
> > > suspend for some sensors). In this way some sensor can wake up the
> > > system.
> > This change is for all ISH platform. Currently, ISH firmware use
> > both SUSPEND_STATE_BIT and CONNECTED_STANDBY_STATE_BIT to identify
> > system state. It is related to system wake up by ISH and it enable
> > each
> > sensor in ISH to be notified the current system state, when system
> > state
> > change.
> What will sensors do with this additional information?
> I think the individual sensors in ISH can decide whether to power OFF
> or ON based on this information to save power during system suspend to
> idle.
Currently, In ISH firmware, we are using CONNECTED_STANDBY_STATE_BIT
(To be compatible with Windows os which are using CONNECTED_STANDBY_STATE_BIT) to
notify sensor system power state. Then some sensor(such as hinge sensor)
can power On/Off itself according to current system power state.

Thanks
Ye Xiang

