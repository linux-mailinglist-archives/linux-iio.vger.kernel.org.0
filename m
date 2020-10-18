Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6752916D6
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 11:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgJRJ6i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 05:58:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgJRJ6i (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Oct 2020 05:58:38 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDA5D2137B;
        Sun, 18 Oct 2020 09:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603015117;
        bh=TKNZHz5MyxzGgGk3m4Lmu0HA4y8V960zzlfj9w4ut2s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yfgVbvM3wcewEKGYNDHnmTzUL3nnbesMWddY5yL++O81JFRNAQgKRWfmNjrEIU2cK
         SW/QcxwK6gBauJ2jIhCrPg0OTWqIW+lpFRQMhx30/bfI5E7G5XKYQbE0w+wQfC8v2o
         thabtNaXxB/5gTpx6GXmrXmwkHMxp1bOK1Q3wYzk=
Date:   Sun, 18 Oct 2020 10:58:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 12/29] dt-bindings:iio:dac:ti,dac5571 yaml conversion.
Message-ID: <20201018105839.442666ee@archlinux>
In-Reply-To: <3812d0a0-7a70-d30c-7fd5-705e2fdef89c@geanix.com>
References: <20201011170749.243680-1-jic23@kernel.org>
        <20201011170749.243680-13-jic23@kernel.org>
        <3812d0a0-7a70-d30c-7fd5-705e2fdef89c@geanix.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 11 Oct 2020 19:47:19 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> On 11/10/2020 19.07, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > A few tweaks in this conversion.
> > * The example didn't have the I2C address of 4C in the node name so
> >    fixed that.
> > * The reference voltage in the txt file is an optional binding, but
> >    the driver is making use of it to provide the scaling of the output
> >    channels.  As such I have made it required going forwards.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Sean Nyekjaer <sean@geanix.com>
> >  
> Looks good :)

Hi Sean,  Good to know, but if you are happy to give a formal
Acked-by, or Reviewed-by always appreciated!

Thanks,

Jonathan

> 
> /Sean

