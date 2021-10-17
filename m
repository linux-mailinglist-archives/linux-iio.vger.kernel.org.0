Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD27C43082C
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 12:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241832AbhJQK4k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 06:56:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241828AbhJQK4k (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 06:56:40 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5947760F14;
        Sun, 17 Oct 2021 10:54:28 +0000 (UTC)
Date:   Sun, 17 Oct 2021 11:58:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Maxim Levitsky <maximlevitsky@gmail.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: BMI160 accelerometer on AyaNeo tablet
Message-ID: <20211017115843.2a872fbe@jic23-huawei>
In-Reply-To: <CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com>
References: <CACAwPwb7edLzX-KO1XVNWuQ3w=U0BfA=_kwiGCjZOpKfZpc2pw@mail.gmail.com>
        <CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 16 Oct 2021 19:27:50 +0300
Maxim Levitsky <maximlevitsky@gmail.com> wrote:

>  BMI160: AYA NEA accelometer ID
>     
>     On AYA NEO, the accelerometer is BMI160 but it is exposed
>     via ACPI as 10EC5280
>     
>     Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>

I guess it is hopelessly optimistic to hope that we could let someone
at the supplier know that's a totally invalid ACPI id and that they
should clean up their act.

Curiously it looks like a valid PCI ID pair though for a realtek device.

Ah well.  Applied to the iio-togreg branch of iio.git and pushed out
as testing to see if 0-day can find any issues with it.

Thanks,

Jonathan
 
