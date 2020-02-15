Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0544F15FF83
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2020 18:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgBOReW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Feb 2020 12:34:22 -0500
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:45284 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgBOReV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Feb 2020 12:34:21 -0500
Received: from [192.168.1.106] (227.146.230.94.awnet.cz [94.230.146.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 3FF00251A4;
        Sat, 15 Feb 2020 18:34:18 +0100 (CET)
Date:   Sat, 15 Feb 2020 18:34:12 +0100
From:   David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v5 5/7] iio: light: al3320a implement suspend support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org
Message-Id: <1581788052.188492.0@ixit.cz>
In-Reply-To: <20200215171526.6de754b4@archlinux>
References: <20200211191201.1049902-1-david@ixit.cz>
        <20200211191201.1049902-6-david@ixit.cz> <20200215171526.6de754b4@archlinux>
X-Mailer: geary/3.35.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Feb 15, 2020 at 17:15, Jonathan Cameron <jic23@kernel.org> 
wrote:
> SIMPLE_DEV_PM_OPS

Hello Jonathan,

sorry about al3320a, I didn't compile test it :(

Missing static for SIMPLE_DEV_PM_OPS is also valid for AL3010.

Sorry for inconvience.

David



