Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEB637F62F
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 13:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbhEMLCT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 07:02:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232226AbhEMLCJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 07:02:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FDB2611BE;
        Thu, 13 May 2021 11:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620903659;
        bh=YXLCuwcON4n32bYUAQ0iiYQxhsUG0yDo7ecdRHK+GGo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=cemf6uxKxozht0K3j1A57GGN4g4cbWw2w4gZZpw9W2je50S8noTX+Jlivh2qRytre
         7PQIGqUZ+9u0y+ez/EVMBpXO72RGbBblpTjvlyGNXNYOwpWwDSf2i21UsPPOgGGeaZ
         XUP8+9FDfzFmvrVPUnf6OEaETgCpTJ7654jL0NlMT9ZnZrLoATMT1DlInsJD00BYYZ
         RwXsdxLvMQFZyp6HeG70Wtn2Jd77farKaejPMy/9FLt34m05mQrm8I5n5oFNEQexQt
         hw980pqSBYi0+2Ic8ATHAs8SDnIFRSNNLIP1McnzEcedtZhd3nR1F/T9VXE9RVXo7m
         Epv7pTsy+PXtg==
Date:   Thu, 13 May 2021 13:00:56 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
cc:     "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "jiapeng.chong@linux.alibaba.com" <jiapeng.chong@linux.alibaba.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "abaci@linux.alibaba.com" <abaci@linux.alibaba.com>
Subject: Re: [PATCH 2/2] HID: hid-sensor-custom: Process failure of
 sensor_hub_set_feature()
In-Reply-To: <7d2c6d4e918485cba09d43702a2a78ae68550ab2.camel@intel.com>
Message-ID: <nycvar.YFH.7.76.2105131300410.28378@cbobk.fhfr.pm>
References: <20210415185232.2617398-1-srinivas.pandruvada@linux.intel.com>  <20210415185232.2617398-2-srinivas.pandruvada@linux.intel.com>  <nycvar.YFH.7.76.2105051437420.28378@cbobk.fhfr.pm>  <CAO-hwJJM5F-1PAh62JSW+GAivMRpgjBiPT2Jvf7+vNcL=HRhGw@mail.gmail.com>
 <7d2c6d4e918485cba09d43702a2a78ae68550ab2.camel@intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 6 May 2021, Pandruvada, Srinivas wrote:

> Rebased and attached based on top of the latest mainline.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

