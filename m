Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F76370E41
	for <lists+linux-iio@lfdr.de>; Sun,  2 May 2021 19:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhEBRuG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 May 2021 13:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230110AbhEBRuG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 May 2021 13:50:06 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C52DA611C0;
        Sun,  2 May 2021 17:49:11 +0000 (UTC)
Date:   Sun, 2 May 2021 18:50:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lucas Stankus <lucas.p.stankus@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/2] staging: iio: cdc: ad7746: add dt properties for
 capacitive channel setup
Message-ID: <20210502185002.4c2faead@jic23-huawei>
In-Reply-To: <cover.1619841953.git.lucas.p.stankus@gmail.com>
References: <cover.1619841953.git.lucas.p.stankus@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 1 May 2021 09:32:03 -0300
Lucas Stankus <lucas.p.stankus@gmail.com> wrote:

> This patch series aims to replace the platform_struct for the ad7746 driver
> in favor of device tree bindings, creating the dt-binding documentation in
> the process.
> 
> Since the header file was only used to define the struct and the excitation
> level values, it was possible to remove the file entirely.
> 
> Changelog v2 -> v3:
> - Add application reference note for the inverted EXCX dt bindings
> - Replace macro with lookup table for setting the capacitive channel
>   excitation voltage
> 
> Lucas Stankus (2):
>   dt-bindings: staging: iio: cdc: ad7746: add binding documentation for
>     AD7746
>   staging: iio: cdc: ad7746: use dt for capacitive channel setup.

Looks good to me.  Thanks!

Will leave time for Rob or anyone else to take a look etc before applying.

If I seem to have lost it then feel free to give me a poke in a few weeks
(it's happened a few times in the past :( 

Thanks,

Jonathan
> 
>  .../bindings/iio/cdc/adi,ad7746.yaml          | 77 +++++++++++++++++++
>  drivers/staging/iio/cdc/ad7746.c              | 54 ++++++++-----
>  drivers/staging/iio/cdc/ad7746.h              | 28 -------
>  3 files changed, 110 insertions(+), 49 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml
>  delete mode 100644 drivers/staging/iio/cdc/ad7746.h
> 

