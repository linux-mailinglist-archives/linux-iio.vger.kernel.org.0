Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E717842222E
	for <lists+linux-iio@lfdr.de>; Tue,  5 Oct 2021 11:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbhJEJXu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Oct 2021 05:23:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233174AbhJEJXt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 5 Oct 2021 05:23:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38A8D610C9;
        Tue,  5 Oct 2021 09:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633425719;
        bh=bMO5K6cxQYzb1BQ1cumIVlI6jj3j6n9qj2qAF5BBJPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=owCpyl5rkRRR86miHBx2uvxl4gbxFbGgEjeTqsoH5s1gQgIrznht9Ev2YXl/X8MUO
         ooyx0g7ABDAOwe2G4907TAnDOPk8m55te4iHzTwBBNu/yHS1IeRtNxf8B5qq1oOFk9
         cpskyg4d39fkiEFLKeddAyE9plMAzfjg2hJHEjXw=
Date:   Tue, 5 Oct 2021 11:21:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 1st set of IIO fixes for the 5.15 cycles
Message-ID: <YVwZHvRyhPF2vr71@kroah.com>
References: <20211004202726.6dfbad58@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004202726.6dfbad58@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 04, 2021 at 08:27:26PM +0100, Jonathan Cameron wrote:
> The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
> 
>   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.15a

Pulled and pushed out, thanks!

greg k-h
