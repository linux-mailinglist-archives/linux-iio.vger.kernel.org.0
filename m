Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D5431D8E9
	for <lists+linux-iio@lfdr.de>; Wed, 17 Feb 2021 12:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbhBQL5F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Feb 2021 06:57:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:48848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232377AbhBQL43 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 17 Feb 2021 06:56:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F171E6024A;
        Wed, 17 Feb 2021 11:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613562945;
        bh=QVdC0kU6jvzs+zB5lNoccmInKiPDjsnzbqv6e9gAuVo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=LFygKx8G6a6cR9opfRPviyHwluOcVDE1WCf5TDDheCfjUfSHPthfNxErDn5E5gkjW
         DOUNQM6zdEbxe54nRBF8TaiLWbET5FfwA5VrDNrkZUJZUWOICw7p8DP4n9EuY3Qq4P
         nVnxyYdNjEaY8Hc4SGMJMS3y9WcpSfSmbZ/zrWwoEyE+u3G6h/Qlr2rQteDbgZNMG5
         6fG6Vl/hfhpUjl5wXuD+pzf3ucYXrCRjLP6EfIr5TdMyGomjYdaerJ465reCAO6TYp
         783DhmPzmzX+WfHRM73A8H/zv/IvIVoSa0FAT9r3ggVPtKtcBIUKVrZfUHKR1TUphf
         h7D3kyzrjocUg==
Date:   Wed, 17 Feb 2021 12:55:41 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
cc:     Ye Xiang <xiang.ye@intel.com>, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: Add relative sensitivity support
In-Reply-To: <20210212182809.2cc90cfd@archlinux>
Message-ID: <nycvar.YFH.7.76.2102171255250.28696@cbobk.fhfr.pm>
References: <20210207070048.23935-1-xiang.ye@intel.com> <20210207070048.23935-2-xiang.ye@intel.com> <20210212182809.2cc90cfd@archlinux>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Feb 2021, Jonathan Cameron wrote:

> > Some hid sensors may use relative sensitivity such as als sensor.
> > This patch adds relative sensitivity checking for all hid sensors.
> > 
> > Signed-off-by: Ye Xiang <xiang.ye@intel.com>
> Hi,
> 
> One totally trivial extra line below.  I'll fix that whilst applying
> unless you need to respin for some reason.
> 
> I'm fine with the series, but looking for an Ack from Jiri
> for the HID header changes.

Acked-by: Jiri Kosina <jkosina@suse.cz>

Thanks,

-- 
Jiri Kosina
SUSE Labs

