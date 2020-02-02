Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19EF714FE95
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2020 18:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgBBRU6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Feb 2020 12:20:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:55410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgBBRU6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Feb 2020 12:20:58 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70B4920679;
        Sun,  2 Feb 2020 17:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580664057;
        bh=i8fbY+4DQZZaQ3aI+CbWWyZqtey3G31JhiW6ObXQuCk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LKDuY+3uIZHE8D3FVwZYjOKau1NjT6VcSPl6rQJRV1X5MQ+bYuwJXjt07Y2CQ/c19
         PaOXCfoP4Ew7FFOJY0uKnaxSaq6P+mhAPu5RdzM00lBTWP+hb2QPiau0crxb01JGGp
         LMjt1CuMpCaT4OCk6uLAcV6LmzaU17tgeCF9dfA0=
Date:   Sun, 2 Feb 2020 17:20:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eugene Zalkonnikov <ez@norphonic.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] Driver for TI HDC20x0 humidity and temperature
 sensors
Message-ID: <20200202172052.009a8e6a@archlinux>
In-Reply-To: <DB6PR06MB3048FDB25F41B31D6A0FC4BFCA010@DB6PR06MB3048.eurprd06.prod.outlook.com>
References: <101D4944-A6B0-4CF7-AF6E-A6196619E3CF@norphonic.com>
        <20200202154205.66df20a0@archlinux>
        <DB6PR06MB3048FDB25F41B31D6A0FC4BFCA010@DB6PR06MB3048.eurprd06.prod.outlook.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2 Feb 2020 17:05:02 +0000
Eugene Zalkonnikov <ez@norphonic.com> wrote:

> Hi Jonathan,
> 
> 
> You mention some pending issue with dt-bindings on this but I have nothing in my inbox so far.
> 
> --
>   Eugene.
Rob's email must have gotten stuck somewhere for you.

https://lore.kernel.org/linux-iio/20200127155421.GA21914@bogus/
