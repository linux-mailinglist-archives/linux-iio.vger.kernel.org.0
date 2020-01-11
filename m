Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1057B1381F0
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2020 16:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbgAKPHn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Jan 2020 10:07:43 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:23167 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729839AbgAKPHn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Jan 2020 10:07:43 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47w3B40h3Lz39;
        Sat, 11 Jan 2020 16:07:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1578755260; bh=2q0NAw9Nx5Ha+nFEzKlRrqZS+QI5q+qryaCdFzo7Ppk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A1dV1/kNbDB9WTdU0Errdj75ZUiFT5MCnz85Od4hd3ZKO5QSUggYWzWUhVNYPHnyP
         9k5ZpUCR9o7TI14jXfJnFd3ljQ+3ZWYI1EsrB4w1qgjIOTQxj/ohJHpvtzGte64c/R
         fNxAzM2l1ojVPtP627MSptJlWzgJ1UdEghCc62uvKp38WzBu5xVULDylcSlmON0m6l
         18czAbsVT+L3cUAOZxHT84hz9n0QNz0jLMhruXS9gAQF3o4wX9uv7dXKzdq2FcrTJ4
         OMv/vJUr7SZK0P6kpvWbFYCHadLEIkp09v6gaQw15Zjz/X4myFWqXO3Yt1QXgQGAlM
         LZ6cbQd2U/G8Q==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Sat, 11 Jan 2020 16:07:35 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu/mpu6050: support dual-edge IRQ
Message-ID: <20200111150735.GA16291@qmqm.qmqm.pl>
References: <MN2PR12MB33737F067F25B2F7477C4FE5C43C0@MN2PR12MB3373.namprd12.prod.outlook.com>
 <e5b39c16dc6dcb25324f6e8389cc0d0f895c1cbd.1578309319.git.mirq-linux@rere.qmqm.pl>
 <20200111121047.79e16365@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200111121047.79e16365@archlinux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jan 11, 2020 at 12:10:47PM +0000, Jonathan Cameron wrote:
> On Mon, 06 Jan 2020 12:17:54 +0100
> Micha³ Miros³aw <mirq-linux@rere.qmqm.pl> wrote:
> 
> > Make mpu6050 usable on platforms which provide only any-edge interrupts.
> > This also covers shared interrupt case.
> 
> So this had me confused for a bit because I assumed we were trying to make
> a level interrupt providing device work with edge interrupts.  Seems
> device supports a pulsed  mode and the driver supports this.
> 
> Why do we want to detect on both edges?  Do you have a crazy board
> with this shared and some devices using the rising edge and some the falling one?
> 
> For shared case it should return that it did not handle the interrupt
> to allow spurious interrupt detection to work...

Hmm. The shared interrupt is a red herring. I'll remove the sentence
from commitmsg as it looks like the driver needs a few more fixups
to be able to share the interrupt line.

The patch is required on platforms that support only dual-edge
interrupts, like eg. AT91SAM9G45-based one I have.

Best Regards,
Micha³ Miros³aw
