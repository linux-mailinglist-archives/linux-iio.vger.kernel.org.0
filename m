Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8046A41DF26
	for <lists+linux-iio@lfdr.de>; Thu, 30 Sep 2021 18:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352080AbhI3Qid (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Sep 2021 12:38:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352059AbhI3Qid (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 30 Sep 2021 12:38:33 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4C5B61250;
        Thu, 30 Sep 2021 16:36:48 +0000 (UTC)
Date:   Thu, 30 Sep 2021 17:40:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
Cc:     jbhayana@google.com, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com
Subject: Re: [PATCH v3 0/1] iio/scmi: Add reading "raw" attribute.
Message-ID: <20210930174043.0845f6ed@jic23-huawei>
In-Reply-To: <20210928161957.24628-1-andriy.tryshnivskyy@opensynergy.com>
References: <20210928161957.24628-1-andriy.tryshnivskyy@opensynergy.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Sep 2021 19:19:56 +0300
Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com> wrote:

> This patch implements reading "raw" attribute.
> 
> The patch is based on v5.14.
> 
> Comparing to the previous version it has:
> * adaptation for changes in structure scmi_iio_priv (no member named 'handle')
> 
Ah.. If you have a case like this where you send out a new version because you've
found an issue yourself, please also reply to the earlier version to say what the
problem was.  That way no one reviews the wrong version :)

Thanks,

Jonathan

> Any comments are very welcome.
> 
> Thanks,
> Andriy.
> 
> Andriy Tryshnivskyy (1):
>   iio/scmi: Add reading "raw" attribute.
> 
>  drivers/iio/common/scmi_sensors/scmi_iio.c | 45 +++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
> 
> 
> base-commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f

