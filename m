Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B1040C2EC
	for <lists+linux-iio@lfdr.de>; Wed, 15 Sep 2021 11:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbhIOJsI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 15 Sep 2021 05:48:08 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:52529 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbhIOJsI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Sep 2021 05:48:08 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 7DA22FF804;
        Wed, 15 Sep 2021 09:46:47 +0000 (UTC)
Date:   Wed, 15 Sep 2021 11:46:46 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>
Subject: Re: [PATCH v2 05/16] iio: adc: max1027: Minimize the number of
 converted channels
Message-ID: <20210915114646.1d3303d2@xps13>
In-Reply-To: <20210905163406.4d4d86a0@jic23-huawei>
References: <20210902211437.503623-1-miquel.raynal@bootlin.com>
        <20210902211437.503623-6-miquel.raynal@bootlin.com>
        <20210905163406.4d4d86a0@jic23-huawei>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

jic23@kernel.org wrote on Sun, 5 Sep 2021 16:34:06 +0100:

> On Thu,  2 Sep 2021 23:14:26 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > Provide a list of ->available_scan_masks which match the device's
> > capabilities. Basically, the devices is able to scan from 0 to N, N
> > being the highest voltage channel requested by the user. The temperature
> > can be included or not, but cannot be retrieved alone.
> > 
> > The consequence is, instead of reading and pushing to the IIO buffers
> > all channels each time, the "minimum" number of channels will be scanned
> > and pushed based on the ->active_scan_mask.
> > 
> > For example, if the user wants channels 1, 4 and 5, all channels from
> > 0 to 5 will be scanned and pushed to the IIO buffers. The core will then
> > filter out the unneeded samples based on the ->active_scan_mask that has
> > been selected and only channels 1, 4 and 5 will be available to the user
> > in the shared buffer.  
> 
> This explanation is excellent.  If you are respinning it would be great
> to have the essence of it as a comment alongside the code.
> The bit about temp in particular was something I'd missed.

No problem, I'll add a comment inline as well.

> Nice optimization in general.

Thanks!

> Jonathan
>  

Best regards,
Miquèl
