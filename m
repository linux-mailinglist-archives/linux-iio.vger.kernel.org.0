Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A336A31B066
	for <lists+linux-iio@lfdr.de>; Sun, 14 Feb 2021 13:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhBNMvI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 14 Feb 2021 07:51:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:53066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhBNMvI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Feb 2021 07:51:08 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 784FC64E61;
        Sun, 14 Feb 2021 12:50:26 +0000 (UTC)
Date:   Sun, 14 Feb 2021 12:50:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: Add basic unit test for iio_format_value()
Message-ID: <20210214125022.739e6eba@archlinux>
In-Reply-To: <8ae67298-5365-6549-1ccd-7de577ca3939@metafoo.de>
References: <20201215191743.2725-1-lars@metafoo.de>
        <20201215191743.2725-3-lars@metafoo.de>
        <20201229181658.5aa5e8d4@archlinux>
        <a856bbff-a292-b988-84e2-cfd3223f220e@metafoo.de>
        <8ae67298-5365-6549-1ccd-7de577ca3939@metafoo.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 7 Feb 2021 13:45:02 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 1/2/21 3:59 PM, Lars-Peter Clausen wrote:
> > On 12/29/20 7:16 PM, Jonathan Cameron wrote:  
> >> On Tue, 15 Dec 2020 20:17:43 +0100
> >> Lars-Peter Clausen <lars@metafoo.de> wrote:
> >>  
> >>> The IIO core provides a function to do formatting of fixedpoint 
> >>> numbers.
> >>>
> >>> In the past there have been some issues with the implementation of the
> >>> function where for example negative numbers were not handled correctly.
> >>>
> >>> Introduce a basic unit test based on kunit that tests the function and
> >>> ensures that the generated output matches the expected output.
> >>>
> >>> This gives us some confidence that future modifications to the function
> >>> implementation will not break ABI compatibility.
> >>>
> >>> To run the unit tests follow the kunit documentation and add
> >>>
> >>>    CONFIG_IIO=y
> >>>    CONFIG_IIO_TEST_FORMAT=y
> >>>
> >>> to the .kunitconfig and run
> >>>
> >>>    > ./tools/testing/kunit/kunit.py run
> >>>    Configuring KUnit Kernel ...
> >>>    Building KUnit Kernel ...
> >>>    Starting KUnit Kernel ...
> >>> ============================================================
> >>>    ======== [PASSED] iio-format ========
> >>>    [PASSED] iio_test_iio_format_value_integer
> >>>    [PASSED] iio_test_iio_format_value_fixedpoint
> >>>    [PASSED] iio_test_iio_format_value_fractional
> >>>    [PASSED] iio_test_iio_format_value_fractional_log2
> >>>    [PASSED] iio_test_iio_format_value_multiple
> >>> ============================================================
> >>>    Testing complete. 21 tests run. 0 failed. 0 crashed.
> >>>    Elapsed time: 8.242s total, 0.001s configuring, 3.865s building, 
> >>> 0.000s running
> >>>
> >>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>  
> >> Series looks good to me, but I wonder.  What is convention wrt to
> >> MAINTAINERS / Acks etc for self tests?  
> >
> > Let's ask Brendan.
> >  
> Jonathan, since there hasn't been any additional feedback should we just 
> apply this series?
> 
Sure, it's been long enough.

Applied to the togreg branch of iio.git and pushed out as testing for
all the normal reasons.

Thanks,

Jonathan

> Thanks,
> 
> - Lars
> 

