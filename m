Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5066841DD4F
	for <lists+linux-iio@lfdr.de>; Thu, 30 Sep 2021 17:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343666AbhI3PYH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Sep 2021 11:24:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343668AbhI3PYH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 30 Sep 2021 11:24:07 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F17E7619EE;
        Thu, 30 Sep 2021 15:22:22 +0000 (UTC)
Date:   Thu, 30 Sep 2021 16:26:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
Cc:     jbhayana@google.com, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com
Subject: Re: [PATCH 1/1] iio/scmi: Add reading "raw" attribute.
Message-ID: <20210930162618.0c53ec33@jic23-huawei>
In-Reply-To: <18401c96-a88e-c7fa-8f20-56605945891d@opensynergy.com>
References: <20210922065235.12891-1-andriy.tryshnivskyy@opensynergy.com>
        <20210922065235.12891-2-andriy.tryshnivskyy@opensynergy.com>
        <20210925154310.2f31c032@jic23-huawei>
        <18401c96-a88e-c7fa-8f20-56605945891d@opensynergy.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


> >> +             /* Use 32-bit value, since practically there is no need in 64 bits */
> >> +             *val = (u32)readings[ch->scan_index].value;  
> > We should check it fits and if doesn't return an error rather than pretending all was fine.
> >  
> What kind of error to return in the case it does not fit - ENOEXEC (Exec format error) ?

That one is a bit obscure.

I'd go with either -ERANGE I think as we are reflecting that the clamp to 32 bit
is not representable.
