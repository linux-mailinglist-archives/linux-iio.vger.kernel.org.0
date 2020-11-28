Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4216B2C753E
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732814AbgK1VtZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:47488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730502AbgK1SlR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 13:41:17 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53386246B0;
        Sat, 28 Nov 2020 15:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606577974;
        bh=2l7SriDc+cS34lE/6C3WpeiJUZvaYDDzy7eIfEmyDeQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DiJBtCrdnYjR+RnkfeTEaM6iazQ9N5bVONlssBDMXDCQXo9vqhqOsfalUycwsOBbc
         8wo1tq8icuBSSXIHbaP9NjJV5eLENS8Bg5hkhpNbxOpkeF11BxOl7u8bMYokPDUJtJ
         sllzbmCu1RBpO9xtveLMe58jARcHFOmXGMqFaBWE=
Date:   Sat, 28 Nov 2020 15:39:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Denis CIOCCA <denis.ciocca@st.com>
Subject: Re: [PATCH] iio: common: st_sensors: fix possible infinite loop in
 st_sensors_irq_thread
Message-ID: <20201128153929.0e1f4419@archlinux>
In-Reply-To: <CACRpkdaAuppq8PesYRv-8Tww0saRbJu2XmYzGWnTm5Rdm-xZHg@mail.gmail.com>
References: <3b8dc467b30dd6869ea60ed583cad750c74eb44e.1605450804.git.lorenzo@kernel.org>
        <CACRpkdaAuppq8PesYRv-8Tww0saRbJu2XmYzGWnTm5Rdm-xZHg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 Nov 2020 23:50:51 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sun, Nov 15, 2020 at 3:38 PM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> 
> > Return a boolean value in st_sensors_new_samples_available routine in
> > order to avoid an infinite loop in st_sensors_irq_thread if
> > stat_drdy.addr is not defined or stat_drdy read fails
> >
> > Fixes: 90efe05562921 ("iio: st_sensors: harden interrupt handling")
> > Reported-by: Jonathan Cameron <jic23@kernel.org>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>  
> 
> This looks more clear if nothing else.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Denis,

This is in the 'obviously' correct category but I've been wrong before
so would ideally like you to you sanity check this one and Ack.

thanks,

Jonathan

> 
> Yours,
> Linus Walleij

