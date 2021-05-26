Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392B0391557
	for <lists+linux-iio@lfdr.de>; Wed, 26 May 2021 12:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbhEZKvG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 May 2021 06:51:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233911AbhEZKvF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 May 2021 06:51:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEFD26023D;
        Wed, 26 May 2021 10:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622026173;
        bh=1UmwkhMDUasdphU3uCe7yFZsBFFDdjtrmpQ46DdPFfU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=W6AL7K6qu5LgOaIhUrT9sbplYaG3VAttvpC8p0D+c/1v7tCq4fyR6vv8RXqou2fm+
         C1ZGkpdJ4xfcBYFJ0JpW/ICP2u3aIlG9vhBkRt88UhVKqBLu6hKRLEtKE9kxkGitmv
         0fWguVn+0Gi0Zj8nJOOV1/aDFmWnXXpkXo85ow5F73ULzbfRMvlaLcp3Pq6aIeI4F4
         ZJouvvdvxIuNQbtTNUAeRpXCpLh2hJCV+tkS4Qy2ceyhHvjxu2QYBG780UNdmAvHgE
         dOpmrtjyXkyE8vy8EIsdpmrWRacXIcIiaoCN8b1Lqz8hsXteKljE/KSkN7vG+omx2L
         KE5D6eaVRp/yg==
Date:   Wed, 26 May 2021 12:49:30 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Ye Xiang <xiang.ye@intel.com>
cc:     jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: intel-ish-hid: ipc: Add Alder Lake device IDs
In-Reply-To: <20210517063609.23267-1-xiang.ye@intel.com>
Message-ID: <nycvar.YFH.7.76.2105261249230.28378@cbobk.fhfr.pm>
References: <20210517063609.23267-1-xiang.ye@intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 May 2021, Ye Xiang wrote:

> Add Alder Lake PCI device IDs to the supported device list.

Applied.

-- 
Jiri Kosina
SUSE Labs

