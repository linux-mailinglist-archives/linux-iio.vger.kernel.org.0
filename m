Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2E53CA7B0
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 20:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242097AbhGOSz4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Jul 2021 14:55:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241889AbhGOSyj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 15 Jul 2021 14:54:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8178613C4;
        Thu, 15 Jul 2021 18:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626375106;
        bh=szkVf8VkFhpsu4g2RfO3cWKYx15qXcEHUrQf1gZVuSc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=I+KseXXFVkAI6iRsrO6p00SQfeIODEVfHNgDKPpFMo+QRwTe9a/5QrQqX0YxKJbN5
         ClN+5l6BaxqIU+tOZNTqZooTsvzsq4kjb0kwCtgKGA5YJ6scea/Ym1TpSZXqvNNmsk
         6WDXGY+xm0Y+t1Ve4mYle3PuG/XOQKVkCCrKh/b35FMJaTIHRU/MgFoZpTq5VA4BxT
         tATYrpkbLttt+k1VNJa/wBHsuFfy2M81d+1cMnkzI/jRCOmqpJiQcVOulSHi+Aswqv
         LPcNqJAreoNsoBIsguGwdIXv2PtYAgRx0gB8zePArT/g0dmsPO+YIVOFZU1EwDZFxY
         7Qgq1GHeshA5A==
Date:   Thu, 15 Jul 2021 20:51:43 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Ye Xiang <xiang.ye@intel.com>
cc:     jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: intel-ish-hid: use async resume function
In-Reply-To: <20210613032507.7474-1-xiang.ye@intel.com>
Message-ID: <nycvar.YFH.7.76.2107152051340.8253@cbobk.fhfr.pm>
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

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

