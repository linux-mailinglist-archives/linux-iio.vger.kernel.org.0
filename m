Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08BA2573AD
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2019 23:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfFZVfH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jun 2019 17:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfFZVfG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Jun 2019 17:35:06 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 122AF208E3;
        Wed, 26 Jun 2019 21:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561584905;
        bh=6lw8//ZI3m6T/YSyYEihgt0NkPbrqatH8bZSVkI2Tr0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=zI9vuyN+pMakFfUheWmNZMGvaT1UoI5jkFfQCsSOGcZUERRPk0curHNtOftpt/Kkb
         uD+zxXCGOE6t1MIJ1mSvkFlIfKc8aym1ALWLTV26xAU3nmsPiM79SJeZ61IQCe+e7x
         J4CA6ZHMxDlswgV5KYvPCbSnzVuz7surlhpaCgko=
Date:   Wed, 26 Jun 2019 23:35:02 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     hongyan.song@intel.com, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, hdegoede@redhat.com, jic23@kernel.org,
        even.xu@intel.com
Subject: Re: [PATCH v3] hid: remove NO_D3 flag when remove driver
In-Reply-To: <67a1ec6dd44866c29333f5b05184cc402bc20382.camel@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.1906262334161.27227@cbobk.fhfr.pm>
References: <1559434641-11783-1-git-send-email-hongyan.song@intel.com>  <nycvar.YFH.7.76.1906261406120.27227@cbobk.fhfr.pm> <67a1ec6dd44866c29333f5b05184cc402bc20382.camel@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 26 Jun 2019, Srinivas Pandruvada wrote:

> > Srinivas, I'd prefer changes like this to go to Linus tree in merge 
> > window and not -rc phase, so I'll do that unless you tell me there is 
> > a good reason to push it to Linus still in -rc.
> Correct. I will tell you if it is important enough to go to -rc
> release, otherwise all changes you can assume for the next merge
> window.

Thanks for your confirmation. Now queued in for-5.3/ish.

-- 
Jiri Kosina
SUSE Labs

