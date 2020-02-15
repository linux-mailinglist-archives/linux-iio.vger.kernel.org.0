Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D19EA15FFAE
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2020 19:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgBOSeI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Feb 2020 13:34:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgBOSeI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Feb 2020 13:34:08 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A93BB206D6;
        Sat, 15 Feb 2020 18:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581791648;
        bh=IJz5dD7eOdUegJgdiYI6jkKC2a+7LbE45DR8f4yW944=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ddecy8atju/mHDYimgsx0/DjOcdcrFKCmWPF1giLReSK9+80nzTQNZ5eH9xUehHF/
         Oh1ch0aPk9QaM+w2APrnTxaGPB5PKSsVATjNL03tehMMRmCMp/Paq1hAk0WhQckKRe
         A/PvWXoslQKgsvA427KNq+qU23DEGwtdbhAEumOQ=
Date:   Sat, 15 Feb 2020 18:34:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 5/7] iio: light: al3320a implement suspend support
Message-ID: <20200215183403.2157b7bc@archlinux>
In-Reply-To: <1581788052.188492.0@ixit.cz>
References: <20200211191201.1049902-1-david@ixit.cz>
        <20200211191201.1049902-6-david@ixit.cz>
        <20200215171526.6de754b4@archlinux>
        <1581788052.188492.0@ixit.cz>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 15 Feb 2020 18:34:12 +0100
David Heidelberg <david@ixit.cz> wrote:

> On Sat, Feb 15, 2020 at 17:15, Jonathan Cameron <jic23@kernel.org> 
> wrote:
> > SIMPLE_DEV_PM_OPS
> 
> Hello Jonathan,
> 
> sorry about al3320a, I didn't compile test it :(
> 
> Missing static for SIMPLE_DEV_PM_OPS is also valid for AL3010.
Yup :) Got that one as well.

Jonathan

> 
> Sorry for inconvience.
> 
> David
> 
> 
> 

