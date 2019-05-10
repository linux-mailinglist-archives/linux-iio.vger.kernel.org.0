Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1038319AC7
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2019 11:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfEJJgN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 May 2019 05:36:13 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:37755 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbfEJJgE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 May 2019 05:36:04 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id D09EE20011;
        Fri, 10 May 2019 09:35:59 +0000 (UTC)
Message-ID: <4a77d53966d117bc5c7ff2836634d8591633f4f5.camel@hadess.net>
Subject: Re: [RFC v2] iio: input-bridge: optionally bridge iio acceleometers
 to create a /dev/input interface
From:   Bastien Nocera <hadess@hadess.net>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eric Piel <eric.piel@tremplin-utc.net>,
        linux-input@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Date:   Fri, 10 May 2019 11:35:58 +0200
In-Reply-To: <7440F555-5A92-442C-B217-BE17EEF9EF68@goldelico.com>
References: <195994ebff28de22eae872df134d086c761b83b8.1554026986.git.hns@goldelico.com>
         <20190407133037.0ad98897@archlinux>
         <CD44AFA0-6676-4842-9C80-61BB363DD556@goldelico.com>
         <20190414124029.1f1f6084@archlinux>
         <CD6219BE-61FF-4C38-9532-054C60A77F89@goldelico.com>
         <20190422152014.7c6637ab@archlinux>
         <b5e40ab0d5aad247b7cb9539c198e04096c516c1.camel@hadess.net>
         <7440F555-5A92-442C-B217-BE17EEF9EF68@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 (3.32.1-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2019-05-10 at 11:33 +0200, H. Nikolaus Schaller wrote:
> > 
<snip>
> It does through "Input device name:" starting with "iio-bridge:" as
> you can see in the commit message of [RFC v3]:

This makes it ABI, right?

Big fat warnings around the code that declares it would be appreciated.

