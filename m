Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C1F3B458D
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jun 2021 16:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhFYObQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Jun 2021 10:31:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:65243 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230088AbhFYObQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 25 Jun 2021 10:31:16 -0400
IronPort-SDR: qlC6po9CBhwhhMKA4xt9NFOi6eKkP41mNd5IVNs6VsVWdm50Wu5efUce2OvLyBtQiw9l0or+//
 n5hnhEkDtNwg==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="207613937"
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="207613937"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 07:28:54 -0700
IronPort-SDR: WNAtepcf9idkm4AAbzyigIodSHEissUxezIBiZis8HmDzBHjtSpRVQgtbeTpSiZxAJtAeFwJDR
 OkO2lcDW3iGQ==
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="642645656"
Received: from sye-mobl.amr.corp.intel.com ([10.212.236.130])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 07:28:53 -0700
Message-ID: <5069e4c3d8f88d4a72155bf3d15282cbba8e7429.camel@linux.intel.com>
Subject: Re: [PATCH] HID: intel-ish-hid: use async resume function
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>, Ye Xiang <xiang.ye@intel.com>
Cc:     jic23@kernel.org, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 25 Jun 2021 07:28:52 -0700
In-Reply-To: <nycvar.YFH.7.76.2106251412250.18969@cbobk.fhfr.pm>
References: <20210613032507.7474-1-xiang.ye@intel.com>
         <nycvar.YFH.7.76.2106251412250.18969@cbobk.fhfr.pm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2021-06-25 at 14:12 +0200, Jiri Kosina wrote:
> On Sun, 13 Jun 2021, Ye Xiang wrote:
> 
> > ISH IPC driver uses asynchronous workqueue to do resume now, but
> > there is
> > a potential timing issue: when child devices resume before bus
> > driver, it
> > will cause child devices resume failed and cannot be recovered
> > until
> > reboot. The current implementation in this case do wait for IPC to
> > resume
> > but fail to accommodate for a case when there is no ISH reboot and
> > soft
> > resume is taking time. This issue is apparent on Tiger Lake
> > platform with
> > 5.11.13 kernel when doing suspend to idle then resume(s0ix) test.
> > To
> > resolve this issue, we change ISHTP HID client to use asynchronous
> > resume
> > callback too. In the asynchronous resume callback, it waits for the
> > ISHTP
> > resume done event, and then notify ISHTP HID client link ready.
> > 
> > Signed-off-by: Ye Xiang <xiang.ye@intel.com>
> 
> Srinivas, can I please get your Ack for this one?
Done.

Thanks,
Srinivas

> 
> Thanks,
> 


