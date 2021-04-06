Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8D7354ECD
	for <lists+linux-iio@lfdr.de>; Tue,  6 Apr 2021 10:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244387AbhDFIlZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Apr 2021 04:41:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233630AbhDFIlZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 6 Apr 2021 04:41:25 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 029C4613C2;
        Tue,  6 Apr 2021 08:41:15 +0000 (UTC)
Date:   Tue, 6 Apr 2021 09:41:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 resend 0/2] iio: documentation: Document
 proximity/accel sensor label use
Message-ID: <20210406094131.2fdb4d38@jic23-huawei>
In-Reply-To: <20210405204224.18715-1-hdegoede@redhat.com>
References: <20210405204224.18715-1-hdegoede@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  5 Apr 2021 22:42:22 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi Jonathan,
> 
> AFAICT the v2 of this series is ready for merging, but I'm not seeing it here:
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=testing

It's there.  Was part of a pull request earlier this cycle I think and so
may be somewhat buried in the history.

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/Documentation/ABI/testing/sysfs-bus-iio?h=testing&id=9a6df4b1ab0e467f23ccdcbb82700cfb3eaf44a3

> 
> Hence this resend.
> 
> Regards,
> 
> Hans
> 
> 
> 
> Hans de Goede (2):
>   iio: documentation: Document proximity sensor label use
>   iio: documentation: Document accelerometer label use
> 
>  Documentation/ABI/testing/sysfs-bus-iio | 46 +++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 

