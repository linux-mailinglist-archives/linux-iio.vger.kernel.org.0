Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E64F37A947
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 16:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhEKOaB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 10:30:01 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:22994 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231695AbhEKOaB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 11 May 2021 10:30:01 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4FfgJz6vpgz9C;
        Tue, 11 May 2021 16:28:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1620743332; bh=g0uzjO2epbVe4ZYIqc5bZyHsR0KkcBusnVcUP8KYD5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d6ZYWYn8OWXAuhGqNe0FDYL89QP+I/MSbA99WWJx9187OcT/+V1WGN5rWBynmwM8V
         iTEHQfXvGqZeRfHQRXJnmZaODFAaWrvOiF0dLe0mbkkijlf6oUImvrwwPeXmyUQwA2
         0F/vS8V8CS/1mCLfTMPP/XVyvyfeGg0P/4aZ6og6a39O7y8pWjxlM1RV0wXXtzMBPV
         PqLk4arqhO5e8j9uEAo2WTxPAKYI/uyr+th3x9fMbGCjtvSHW0OLB29L+xU55+v6dG
         55mYK2Mrp1aK7FR2YC7Y7u/4rmySKOX2daM55vJWRlYK2HD6waRwhlx8mlV30h1Dem
         Vu818fjKExtZA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.2 at mail
Date:   Tue, 11 May 2021 16:28:47 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Yang <decatf@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 0/3] iio: accel: kxcjk-1013: Add support for KX023-1025
Message-ID: <20210511142847.GA4413@qmqm.qmqm.pl>
References: <20210511095409.9290-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210511095409.9290-1-stephan@gerhold.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 11, 2021 at 11:54:06AM +0200, Stephan Gerhold wrote:
> KX023-1025 [1] is another accelerometer from Kionix that has lots
> of additional functionality compared to KXCJK-1013. It combines the
> motion interrupt functionality from KXCJK with the tap detection
> from KXTF9, plus a lot more other functionality.

When I researched KXTF9 support it occurred to me that the -10xx part is
duplicating the information in 'KXyyy' - it seems to be a project number
or something. I would suggest to use just 'kx023' prefix for the code
and DT but leave the full identification in the comments/description.

Best Regards
Micha³ Miros³aw
