Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FA92D4654
	for <lists+linux-iio@lfdr.de>; Wed,  9 Dec 2020 17:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgLIQHo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Dec 2020 11:07:44 -0500
Received: from www381.your-server.de ([78.46.137.84]:38144 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgLIQHo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 11:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=ax7NqoU73MA3se1WNsx10TwotLOnIUnjjM5XsgUZgU4=; b=kl7CXQLEaH10L53nz89GIgtKLH
        tXWz6HyedlCVIFAVJEaDgzu/ms4AQTZt0lFA89JuqK7KOs+O5bwiAXoWh8ynizZPDrrdJPLO4bXQp
        2BiwD5Xpx/of/w4LjH+cOVsJGk3xr8vdrzIu1csIz9h912DWoMCafsLZbvvRzxrL2J95lr34PXIYA
        fsoNVV2t+++Lq0dbfiD29EJVcKfBm87/XtLqRGXowxPQf7zd8dx+lmkXTnxV0knn3in7udW/PlQD+
        l+G3o/DyQIfqBbqka4DjjL+0CTALnftrI3a1fXUez+OUCe4wTtKx4brrQsIEouJ9ttoFmXD6r8wgc
        D/e70JMg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kn1zY-0009Wu-Rg; Wed, 09 Dec 2020 17:07:00 +0100
Received: from [62.216.202.54] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kn1zY-000UUR-Nj; Wed, 09 Dec 2020 17:07:00 +0100
Subject: Re: kernel bug tracker
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>
References: <CAHp75VcDJd_ROcPE6GJvz3J4fTp_a=PX2GpjRc3RV16edzYmrA@mail.gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <688821bc-f93c-c98c-974c-ec46fa4111bd@metafoo.de>
Date:   Wed, 9 Dec 2020 17:07:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VcDJd_ROcPE6GJvz3J4fTp_a=PX2GpjRc3RV16edzYmrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26013/Wed Dec  9 15:33:37 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/9/20 4:58 PM, Andy Shevchenko wrote:
> Hi!
>
> Does the I2O actually refer to IIO on kernel bugzilla?
> In any case, default there is Alan Cox' email and I didn't find
> Jonathan's there.
> If the answer is "yes" for above, does make sense to:
>   - change its name to IIO
>   - put mailing list as default assignee?
>
>
There used to be an I2O subsystem, but which has been removed[1].

I supposed if it is used for IIO drivers at the moment I supposed we can 
take over the tag and rename it to IIO, given that there should be no 
new I2O tickets.

- Lars

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4a72a7af 
<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4a72a7af>

