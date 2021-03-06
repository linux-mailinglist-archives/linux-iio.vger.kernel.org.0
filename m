Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AEA32FC4F
	for <lists+linux-iio@lfdr.de>; Sat,  6 Mar 2021 18:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhCFRfH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 6 Mar 2021 12:35:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:59650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229779AbhCFRey (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Mar 2021 12:34:54 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06F7664FCF;
        Sat,  6 Mar 2021 17:34:52 +0000 (UTC)
Date:   Sat, 6 Mar 2021 17:34:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc:     "zzzzArdelean, zzzzAlexandru" <alexandru.Ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: Re: [PATCH v3 0/6] iio: Add output buffer support
Message-ID: <20210306173449.06f2f32b@archlinux>
In-Reply-To: <BN8PR03MB497724AAAFA43E6555554DC98E969@BN8PR03MB4977.namprd03.prod.outlook.com>
References: <20210219124012.92897-1-alexandru.ardelean@analog.com>
        <20210221120106.00ae1078@archlinux>
        <BN8PR03MB497724AAAFA43E6555554DC98E969@BN8PR03MB4977.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 5 Mar 2021 08:57:08 +0000
"Hennerich, Michael" <Michael.Hennerich@analog.com> wrote:

> Hi Jonathan and others,
> 
> With output/dac buffer support the semantics of the scan_element type may change.
> 
> Today the Format is [be|le]:[s|u]bits/storagebitsXrepeat[>>shift].
> 
> While shift (if specified) is the shift that needs to be applied prior to masking out unused bits.
> 
> So far so good and it sounds universal. 
> 
> However, we use the right shift (operator) for that, which makes sense for capture devices.
> For output devices the more logical operator would be the left shift.
> 
> I'm not proposing a new Format here. I just want to get some agreement that for an output device
> 
> le:s12/16>>4  
> 
> is understood as a left shift of 4, since the unused bits are then on the LSB.

Good question. Guess I wasn't thinking ahead when I came up with that :)

I'm not sure I'd mind if we did decide to define a new format for output
buffers. Feels like it should be easy to do.

What do others think?

Jonathan


> 
> Thoughts?
> 
> Best Regards,
> Michael
> 
> Analog Devices GmbH
> Michael Hennerich                       
> Otl-Aicher Strasse 60-64
> D-80807 Muenchen; Germany
> 
> Sitz der Gesellschaft München, Registergericht München HRB 40368,
> Geschäftsführer: Stefan Steyerl, Michael Paul Sondel, Yoon Ah Oh
> 
> 

