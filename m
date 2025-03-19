Return-Path: <linux-iio+bounces-17120-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1115A69A6C
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 22:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C9F1897885
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 21:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4207C219A7E;
	Wed, 19 Mar 2025 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQ+nMc4L"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAE2215049;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742417985; cv=none; b=SN14Oeg0aoMH1GDIMMqct1RMbvko7cCpoI3bThfO2naN0autFeLIMPwcAlDw1F4p6araVlMHHZD9Af2h6Vs33yWqbpA1g5YCPPIRQY7qeOoEwkz3iqO7CpfpPZAK8bENDyW9YryFuuEtPbtzvaP7Dqn1d2MGeR7ScNZuNPVmCTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742417985; c=relaxed/simple;
	bh=I1QudRTcRzar5C3WjocpB9UgOXiwRUlIuiV6ZhxQUAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WWlUn8ITFX4njqmY0jFn8yZXyY0NBY9H/2PCySLyHnGxXSVQ8mXfzlpc31s8wbiFkVYc35pWVSitznCl7qb5rVnkS5KYh5tzGcIDFe8Y+gtbMDWsp4wRYrBcDNEh4+HG59YHIFNQoBafJJpIURReykpAVLyk1kzNAXfxlqkZ1xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQ+nMc4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58F87C4CEF2;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742417985;
	bh=I1QudRTcRzar5C3WjocpB9UgOXiwRUlIuiV6ZhxQUAk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oQ+nMc4LxswyJpIkMWdMDaczauypeDn4xdtRsjlzcb1/ybGIR3ICsF/nMp06umn5r
	 nCdPn5IaBmhTKKIi1Nf8rDJpR//HrdSkJg4O0jKNqLjrOIegYAfye6fig/8jCG4aBS
	 mdUsEc2xyY8vAtP3HgjiL5kDOAiGbQ8gPgizcg4WIuj85JWAnz0qdKEJtf1NntCL8l
	 7ZSYrdYDHmX2zb4iEExWOBljZBchphzl+8ayzVyID7Zpe2LraK9OmaChO7GcYAI2Dv
	 gtUZu4jsPkGw2N48v8tvQVVxqBgBtDMKglXe5fJexqmKxLfIs/z/gtHtxLJQjwgrB3
	 8kdRfpCELmCkg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51124C36001;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 19 Mar 2025 21:59:45 +0100
Subject: [PATCH v2 06/13] iio: light: al3320a: Abstract device reference in
 the probe function
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-al3010-iio-regmap-v2-6-1310729d0543@ixit.cz>
References: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
In-Reply-To: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1532; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=Ct1gfcrjZUKbkM919cRcq2ZoAee3rgE77Wd7D0kN4IQ=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn2zA9d5MI7y5r0Kp+Il39GDvhw+GAXO+1U68D8
 cpoGkCO4B2JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ9swPQAKCRBgAj/E00kg
 cgrED/0aXuYXLYx7Lx1WaDZQ9DPGyQQuMmWIU6B2lm3T7Wc+VGSAv1FN+d+t1eXoosMwqbSgztF
 ixW6pL4d4YJOsCaYg1FWaWPeNKAo4lxXkMrAinWNqCZck2RohshLweIkbQqG/q1C0vNJeswbo6p
 +6XsHms6myzLQpEZPPkkYKReWBgsOfA/bq38nWXjsAEMMq6hAw/7szTtMsug50DhhKXOeSch0fZ
 M9CIGIcDVlLAPb0wWjWYsmvSuGZ1nlwMLQC+l4j6jEkyzkTzlBP6ByzrlOgArYL/EixHBGgelEj
 9WNbi10ESDReQnx43zVcfX9Auffypjg7Q9ZxZjhk/g2NzySAG/yNJnWRcQPVwqoF0YfgZ1Sd94W
 Flyl+sXMEBPrrOdcJI89H8Q3s+4HM68spBPQHy8B2au5ICMw5woSMgp5H61xN809rPVPXDNvH35
 DoPYHbd7epzP6g0qaaphNylFXVzYFFbHQ5tH0L0inYRbYSa9JIaXpyv9l4rXp+mb+nOF2WT+GK6
 heDYoDCpI3oluivR4XJnzGiFXIKVly6ygBUyBiyTA+iTngC9N3UfBF654wnpnjJUc7372iXLkDv
 NHdsGIvb02tAHf2/RAopJZ/dr5hi2zhVD7UKPXnRbfMtMfvlaXqEe4/Ft1nGpORJP+2jPh+l2ol
 kDa/bDqdbRBqOag==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

Introduce a local variable reducing redundancy and improving readability.

No functional changes.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3320a.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index 93416f3bd7fbb0a75bef17949725d0d40b9b93ea..9817cfe8ae18a8e27c82e7362481ebd32a41f8ec 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -188,10 +188,11 @@ static const struct iio_info al3320a_info = {
 static int al3320a_probe(struct i2c_client *client)
 {
 	struct al3320a_data *data;
+	struct device *dev = &client->dev;
 	struct iio_dev *indio_dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -207,17 +208,15 @@ static int al3320a_probe(struct i2c_client *client)
 
 	ret = al3320a_init(data);
 	if (ret < 0) {
-		dev_err(&client->dev, "al3320a chip init failed\n");
+		dev_err(dev, "al3320a chip init failed\n");
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(&client->dev,
-					al3320a_set_pwr_off,
-					data);
+	ret = devm_add_action_or_reset(dev, al3320a_set_pwr_off, data);
 	if (ret < 0)
 		return ret;
 
-	return devm_iio_device_register(&client->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static int al3320a_suspend(struct device *dev)

-- 
2.49.0



