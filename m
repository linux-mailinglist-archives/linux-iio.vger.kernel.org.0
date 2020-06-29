Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF02120D436
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jun 2020 21:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbgF2TGU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Jun 2020 15:06:20 -0400
Received: from www381.your-server.de ([78.46.137.84]:46342 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729371AbgF2TGT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Jun 2020 15:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XTvylXMPIsFqnfKIAoIZyVNDNeQ+X85fQ4qzs7EoduI=; b=QmS0Aewli0daeHBXlQwTsOn3q8
        nxxCcTfjv0G918ucLK364sfDiZ91JAjTS/vodpcC/V244DUIQuEIBIEH2vWKXKlsE7YRbLF7oQimb
        4WGK573xw3tWw+x5VPRI5YzFPQAywNBHwCh7GS290PTK2XdwdwJULDdFnIRR5CqvhBu7x+0IPkylD
        T9piIkYmf3XtbUBsUQclk6WUICtkzHfiGnTmVyT+f+DrDuaYHOqXUe1iLHDH+mhDaZ6tv0ecdAfMM
        1yrN1oZiQsR1e2BvNuwKe6axxYw+RegZiFYdydZD6nrIQYnb62CLtkqi/4Mx7+QO7qKnS3j/P155M
        5+f/NxDw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jpz6c-00045S-1Z; Mon, 29 Jun 2020 21:06:14 +0200
Received: from [82.135.70.27] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jpz6b-000Gpr-SC; Mon, 29 Jun 2020 21:06:13 +0200
Subject: Re: Interest in a virtual IIO microconf?
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20200628133607.61d31ed1@archlinux>
 <2fd40a0d341cbe7dded2fa9b2f53b4f87b1a2ab8.camel@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <d7124f0b-99cb-0213-329d-dbade7d5a56d@metafoo.de>
Date:   Mon, 29 Jun 2020 21:06:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2fd40a0d341cbe7dded2fa9b2f53b4f87b1a2ab8.camel@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.3/25858/Mon Jun 29 15:30:49 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 6/29/20 3:51 PM, Ardelean, Alexandru wrote:
> There's also an internal idea we had, where we can extend the IIO dummy
> driver [or create a new one], to load data and read-back [as a replay for
> userspace].
> We never got to do it, but would be curios of other did.

Like this?

https://github.com/larsclausen/linux/blob/iio-high-speed-4.19/drivers/iio/dummy/iio_virtual_dma_loopback.c

