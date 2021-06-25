Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827683B42F0
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jun 2021 14:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFYMPE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Jun 2021 08:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhFYMPD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 25 Jun 2021 08:15:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E13646162A;
        Fri, 25 Jun 2021 12:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624623163;
        bh=QJxnAfgsv7H0MV05wG2ckfEIc7HWo8yYqaLFkp2QqyM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=UGgB6fyM4242VjL09luaOMZ7Q6mBrU/5I3WODVWo645g9gDCp6p+e0orNtfE+kOWi
         zHB8fDAcz0BzbWXADlI8ei+aADZ3XBzXGD4jj3AHtS4HKPRMR1r+bpgQBTgeThi9vO
         3qU4g0DkV5o5ITprv0Mu+HttzPJaDTZ8tMqIq1i/U1wFVhk+y6Dbav1BepN7uynyXh
         RgsAwWBvGegijylkgiKQjvtCHiy/CxospUeqnZOpWyz1pw0bj6d/9u2EGwDWN8neto
         jJ4g6ZrDgUd7txGyooK7vMvhqKdkOjMHHXU1pojn94GmsWsMHApXMTyCwp8ZCEcj+x
         O0nlP2VktwFOw==
Date:   Fri, 25 Jun 2021 14:12:39 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Ye Xiang <xiang.ye@intel.com>
cc:     jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: intel-ish-hid: use async resume function
In-Reply-To: <20210613032507.7474-1-xiang.ye@intel.com>
Message-ID: <nycvar.YFH.7.76.2106251412250.18969@cbobk.fhfr.pm>
References: <20210613032507.7474-1-xiang.ye@intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 13 Jun 2021, Ye Xiang wrote:

> ISH IPC driver uses asynchronous workqueue to do resume now, but there is
> a potential timing issue: when child devices resume before bus driver, it
> will cause child devices resume failed and cannot be recovered until
> reboot. The current implementation in this case do wait for IPC to resume
> but fail to accommodate for a case when there is no ISH reboot and soft
> resume is taking time. This issue is apparent on Tiger Lake platform with
> 5.11.13 kernel when doing suspend to idle then resume(s0ix) test. To
> resolve this issue, we change ISHTP HID client to use asynchronous resume
> callback too. In the asynchronous resume callback, it waits for the ISHTP
> resume done event, and then notify ISHTP HID client link ready.
> 
> Signed-off-by: Ye Xiang <xiang.ye@intel.com>

Srinivas, can I please get your Ack for this one?

Thanks,

-- 
Jiri Kosina
SUSE Labs

