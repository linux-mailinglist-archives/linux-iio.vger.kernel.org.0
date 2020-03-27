Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50D9C195819
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 14:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgC0NfL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 09:35:11 -0400
Received: from mx-out2.startmail.com ([145.131.90.155]:52786 "EHLO
        mx-out2.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0NfL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 09:35:11 -0400
Date:   Fri, 27 Mar 2020 15:40:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1585316109;
        bh=B3ie8oOubwFY+Sys4enBz3aY1yXLgBVZ+ICV7cbZufE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RbnVNUsHqnHzmbFqLprNCURsMkAp3asSeklKqz3MVhKvgic9iSPYoGaGwL0nL9FFM
         2BxbBPAvBSSeD+tsHJyf7KOnYi1Nqi0E1lBt/yv5pfLMUysW2sREiue5ewWeczO58D
         D3i0EjTmfTgex4KbLpJG1+z03ekom78WHdhGGaeK6bTnpwUw6xUSxdhSL+ESPkIvL+
         7Lw9If6DlEoplVNq3ILofAhwFxDUuPKgT/+VDf/dtysfuVt0nzELFsoOPSBpDTYDsq
         2vse9fjCHuhst2ojEzZkBTOZ9ZGPzCnjLwjO5pSsXUb09NVhFGjiBrBUhqU4DFFa0v
         eGWh4oFNMFXRg==
From:   Alexandru Lazar <alazar@startmail.com>
To:     linux-iio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH v5 0/2] Maxim MAX1241 driver
Message-ID: <20200327134000.GA3579@leena.republic>
References: <20200322140237.211347-1-alazar@startmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200322140237.211347-1-alazar@startmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 22, 2020 at 04:02:35PM +0200, Alexandru Lazar wrote:
> Hello again,
> 
> Here's version 5 of a patch series which adds support for the Maxim
> MAX1241, a 12-bit, single-channel, SPI-connected ADC.

*poke*

No rush here, just wanna make sure this doesn't go off-radar.

Thanks,
Alex
