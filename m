Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41551AD9C4
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 11:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbgDQJYD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 05:24:03 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2057 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730169AbgDQJYD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 17 Apr 2020 05:24:03 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id AC71BA26D8F55EC5BE24;
        Fri, 17 Apr 2020 10:24:02 +0100 (IST)
Received: from localhost (10.47.87.249) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 17 Apr
 2020 10:24:02 +0100
Date:   Fri, 17 Apr 2020 10:23:50 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
CC:     <linux-iio@vger.kernel.org>
Subject: Re: inquiry: where to place iio/ bandpass filter driver
Message-ID: <20200417102350.00003a28@Huawei.com>
In-Reply-To: <55472b69-c587-ca04-d3b9-c8615e6a652d@gtsys.com.hk>
References: <55472b69-c587-ca04-d3b9-c8615e6a652d@gtsys.com.hk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.87.249]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Apr 2020 11:48:31 +0800
Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:

> Hi,
> 
> I'm working on implementation for ltc6602 dual match bandpass filter spi
> driver.
> The driver tree has a iio/frequency which has PLLs at time beeing and
> I wondering to drop my driver there or have a new directory
> freqfilter or bpf ?
> 
> This isn't urgent, but would be nice to know.
> 

Perhaps iio/afe?  It's a type of analog front end (or might be used as such).
Is the intent to wrap these up as a consumer of an ADC?  So they ultimately provide
a unified device presentation to userspace of the ADC + filters. Or are
we looking at simply controlling a filter which doesn't connect to an ADC or DAC
visible to us?

I'm not against a new directory for filters though.  Don't be specific on the
type unless we need to be :)

Jonathan

> Regards
> Chris


